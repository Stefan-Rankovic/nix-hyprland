# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    cfg,
    filterNullsRecursive,
    lib,
    localTypes,
    luaFunctionArguments,
    mkNullOption,
    mkNullSubmodule,
    xNonNullSubmodule,
}:

let
    bindType = import ../../options/binds/bind_type.nix {
        inherit
            lib
            localTypes
            mkNullOption
            mkNullSubmodule
            xNonNullSubmodule
            ;
    };

    mkBind =
        partialBind:
        (lib.evalModules {
            modules = [
                {
                    options.bind = lib.mkOption { type = bindType; };
                    config.bind = partialBind;
                }
            ];
        }).config.bind;

    # === Mouse ===
    mkMouseAttrset =
        { cfg, click }:
        assert lib.isAttrs cfg;
        assert (click == "lmb") || (click == "rmb");
        let
            mouse = cfg.binds.mouse;
            bind_parent = mouse.${click};
            code = if click == "lmb" then "272" else "273";
            key = "mouse:${code}";
            prefixKeys =
                if mouse.keys != null then
                    "${mouse.keys} + "
                else if cfg.binds.mainMod.enable then
                    ""
                else
                    throw "Must either enable `binds.mainMod.enable` or set `binds.mouse.keys` (since binds.mouse.enable is `true`)!";
            useMainMod = prefixKeys == "";
        in
        if (bind_parent.enable == true) || (bind_parent.enable == null && mouse.enable) then
            {
                "${prefixKeys}${key}" = mkBind {
                    inherit useMainMod;
                    flags.mouse = true;
                    dsp.raw_lua.code = "hl.dsp.window.${bind_parent.action}()";
                };
            }
        else
            { };
    allMBs =
        (mkMouseAttrset {
            inherit cfg;
            click = "lmb";
        })
        // (mkMouseAttrset {
            inherit cfg;
            click = "rmb";
        });
in
lib.concatStringsSep "\n" (
    lib.concatLists (
        lib.mapAttrsToList (
            keys: oneOrMoreBinds:
            let
                binds = if builtins.isList oneOrMoreBinds then oneOrMoreBinds else [ oneOrMoreBinds ];
            in
            map (
                bind:
                import ./parse_bind.nix {
                    inherit
                        bind
                        cfg
                        filterNullsRecursive
                        lib
                        keys
                        luaFunctionArguments
                        ;
                }
            ) binds
        ) (lib.attrsets.unionOfDisjoint cfg.binds.list allMBs)
    )
)
