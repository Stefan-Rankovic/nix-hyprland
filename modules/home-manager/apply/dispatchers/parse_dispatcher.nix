# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    dispatcher,
    filterNullsRecursive,
    lib,
    luaFunctionArguments,
}:

let
    # Strip all the noise from the dispatcher, leaving only the one the user chose
    filteredDsp = filterNullsRecursive dispatcher;

    # === Extract name ===
    # Gets the dsp name (as the only key left inside filteredDsp)
    firstLevelName =
        assert builtins.length (builtins.attrNames filteredDsp) == 1;
        builtins.head (builtins.attrNames filteredDsp);
in
if (firstLevelName == "raw_lua") then
    lib.mkLuaInline dispatcher.${firstLevelName}.code
else
    let
        # === Import arguments ===
        allArguments = import ./dsp_arguments { inherit lib; };

        # Is the dsp a top level one such as `exec_cmd` or a nested one like `window.kill`
        isTopLevel = builtins.hasAttr "unnamed" allArguments.${firstLevelName};
        # Nested name, if one
        subName =
            assert builtins.length (builtins.attrNames filteredDsp) == 1;
            if isTopLevel then null else builtins.head (builtins.attrNames filteredDsp.${firstLevelName});
        # Actual function that takes care of cases such as `window` not being the actual dsp name, but instead `kill` (in `window.kill`).
        name =
            assert builtins.length (builtins.attrNames filteredDsp) == 1;
            if isTopLevel then
                firstLevelName
            else
                assert builtins.hasAttr "unnamed" allArguments.${firstLevelName}.${subName};
                "${firstLevelName}.${subName}";
        lastName = if subName == null then firstLevelName else subName;

        # === Arguments ===
        arguments =
            if isTopLevel then allArguments.${firstLevelName} else allArguments.${firstLevelName}.${subName};

        # === Extract value ===
        dsp =
            assert builtins.length (builtins.attrNames filteredDsp) == 1;
            let
                firstLevelDsp = builtins.head (builtins.attrValues filteredDsp);
            in
            if isTopLevel then
                firstLevelDsp
            else
                assert builtins.hasAttr "unnamed" arguments;
                filteredDsp.${firstLevelName}.${subName};

        # === Unnamed arguments ===
        unnamedArguments =
            let
                # Get unnamed dsp arguments using `arguments` and simple filtering
                unnamedDspArguments = lib.attrVals (builtins.filter (
                    potentialUnnamedArg: builtins.hasAttr potentialUnnamedArg dsp
                ) arguments.unnamed) dsp;
                # Get additional ones from getUnnamedFromPre and getUnnamedFromPost
                additionalUnnamedDspArgumentsPre =
                    if
                        arguments.getUnnamedFromPre != null
                        && dsp.${arguments.getUnnamedFromPre} != null
                        && lib.isList dsp.${arguments.getUnnamedFromPre}
                    then
                        dsp.${arguments.getUnnamedFromPre}
                    else
                        [ ];
                additionalUnnamedDspArgumentsPost =
                    if
                        arguments.getUnnamedFromPost != null
                        && dsp.${arguments.getUnnamedFromPost} != null
                        && lib.isList dsp.${arguments.getUnnamedFromPost}
                    then
                        dsp.${arguments.getUnnamedFromPost}
                    else
                        [ ];
            in
            if arguments.isNamed then
                [ ] # Not unnamed but named
            else if arguments.isUnnamed then
                dsp # Dsp itself is set to the unnamed argument, so this just passes that
            else
                # Combine all the lists acquired above
                additionalUnnamedDspArgumentsPre ++ unnamedDspArguments ++ additionalUnnamedDspArgumentsPost;

        # === Named arguments ===
        namedArguments =
            let
                # Get named dsp arguments using `arguments` and simple filtering
                namedDspArguments = lib.filterAttrs (
                    dspArgumentName: _: builtins.elem dspArgumentName arguments.named
                ) dsp;
                # Get additional ones from getNamedFrom
                additionalNamedDspArguments = lib.foldl' (
                    acc: source:
                    if (builtins.hasAttr source dsp) then
                        if builtins.isAttrs dsp.${source} then
                            lib.attrsets.unionOfDisjoint acc dsp.${source}
                        else
                            throw "${source} was a part of getNamedFrom for dsp ${name} yet it exists and is not an attribute set"
                    else
                        acc
                ) { } arguments.getNamedFrom;
                maybeNamedDspArguments = lib.foldl' (
                    acc: source:
                    if (builtins.hasAttr source dsp) then
                        lib.attrsets.unionOfDisjoint acc (
                            if (builtins.isAttrs dsp.${source}) then dsp.${source} else { ${source} = dsp.${source}; }
                        )
                    else
                        acc
                ) { } arguments.getFromOrAreNamed;
            in
            if arguments.isUnnamed then
                { } # Not named but unnamed
            else if arguments.isNamed then
                { ${lastName} = dsp; } # Dsp itself is set to the named argument, so this just passes that
            else
                # Merge both of them into one attrset, erroring on conflict
                lib.foldl' lib.attrsets.unionOfDisjoint { } [
                    namedDspArguments
                    additionalNamedDspArguments
                    maybeNamedDspArguments
                ];

        # === Construct call ===
        dspCallLua =
            let
                # Merge unnamed and named arguments into one list (unnamed arguments representing multiple elements, and named arguments representing one attrset element)
                dspOptionsList = unnamedArguments ++ (lib.optional (namedArguments != { }) namedArguments);
                # Collapse the list into a string split by commas
                dspOptionsString = luaFunctionArguments dspOptionsList;
                # Construct the dispatcher call
                dspCallString = "hl.dsp.${name}(${dspOptionsString})";
            in
            # Mark the dispatcher call as lua-inline
            lib.generators.mkLuaInline dspCallString;
    in
    dspCallLua
