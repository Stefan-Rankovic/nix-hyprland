# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
}:

let
    mkArguments =
        {
            unnamed ? [ ], # The list of unnamed arguments at the top level
            # todo: maybe rework to take lists?
            getUnnamedFromPre ? null,
            getUnnamedFromPost ? null,
            isUnnamed ? false, # Whether the dispatcher itself is an unnamed argument
            named ? [ ], # The list of named arguments at the top level
            getNamedFrom ? [ ], # The list of locations to get named arguments from (if they are nested)
            getFromOrAreNamed ? [ ], # The list of locations to get either one or multiple named arguments
            isNamed ? false, # Whether the dispatcher itself is a named argument (the argument name is the dispatcher's name)
        }:
        assert lib.isList unnamed;
        assert (lib.isString getUnnamedFromPre) || (getUnnamedFromPre == null);
        assert (lib.isString getUnnamedFromPost) || (getUnnamedFromPost == null);
        assert lib.isBool isUnnamed;
        assert
            !isUnnamed
            || (isUnnamed && getUnnamedFromPre == null && getUnnamedFromPost == null && unnamed == [ ]);
        assert lib.isList named;
        assert lib.isList getNamedFrom;
        assert lib.isBool isNamed;
        assert !isNamed || (isNamed && getNamedFrom == [ ] && getFromOrAreNamed == [ ] && named == [ ]);
        {
            inherit
                unnamed
                getUnnamedFromPre
                getUnnamedFromPost
                isUnnamed
                named
                getNamedFrom
                getFromOrAreNamed
                isNamed
                ;
        };
in
{
    cursor = import ./cursor.nix { inherit mkArguments; };
    group = import ./group.nix { inherit mkArguments; };
    window = import ./window.nix { inherit mkArguments; };
    workspace = import ./workspace.nix { inherit mkArguments; };

    exec_cmd = mkArguments {
        unnamed = [ "cmd" ];
        getNamedFrom = [ "rules" ];
    };

    exec_raw = mkArguments { unnamed = [ "cmd" ]; };

    focus = mkArguments {
        named = [
            "direction"
            "monitor"
            "window"
            "urgent_or_last"
            "last"
        ];
        getFromOrAreNamed = [ "workspace" ];
    };

    exit = mkArguments { };

    submap = mkArguments { unnamed = [ "name" ]; };

    pass = mkArguments { named = [ "window" ]; };

    send_shortcut = mkArguments {
        named = [
            "mods"
            "key"
            "window"
        ];
    };

    send_key_state = mkArguments {
        named = [
            "mods"
            "key"
            "state"
            "window"
        ];
    };

    layout = mkArguments { unnamed = [ "message" ]; };

    dpms = mkArguments {
        named = [
            "action"
            "monitor"
        ];
    };

    event = mkArguments { unnamed = [ "string" ]; };

    global = mkArguments { unnamed = [ "string" ]; };

    force_idle = mkArguments { unnamed = [ "seconds" ]; };

    no_op = mkArguments { };
}
