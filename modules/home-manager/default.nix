# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

checkHyprlandVersion:
{
    config,
    lib,
    ...
}:

let
    inherit (lib) types;

    cfg = config.nix-hyprland;

    mkNullOption =
        args:
        assert builtins.isAttrs args;
        assert !(builtins.hasAttr "default" args);
        assert builtins.hasAttr "type" args;
        assert !(lib.hasPrefix "null or" args.type.name);
        lib.mkOption (
            args
            // {
                default = null;
                type = types.nullOr args.type;
            }
        );

    mkNullSubmodule =
        {
            options,
            description ? "",
        }:
        mkNullOption {
            type = types.submodule {
                inherit options;
            };
            inherit description;
        };

    nonNullSubmodule = types.submodule;
    oneNonNullSubmodule = types.submodule;

    doubleElement =
        elementType:
        let
            type = types.listOf elementType;
        in
        type
        // {
            typeMerge = _: null;
            check = v: type.check v && builtins.length v == 2;
        };

    luaFunctionArguments =
        list: builtins.concatStringsSep ", " (map (value: lib.generators.toLua { } value) list);

    localTypes = import ./types {
        inherit
            doubleElement
            lib
            mkNullOption
            nonNullSubmodule
            ;
    };
in
{
    imports = [
        ./apply
        ./options
    ];

    config = lib.mkMerge [
        {
            _module.args = {
                inherit
                    checkHyprlandVersion
                    doubleElement
                    localTypes
                    luaFunctionArguments
                    mkNullOption
                    mkNullSubmodule
                    nonNullSubmodule
                    oneNonNullSubmodule
                    ;
            };
        }
        (lib.mkIf cfg.enable {
            xdg.configFile."uwsm/env".source =
                "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

            wayland.windowManager.hyprland = {
                inherit (cfg)
                    enable
                    package
                    ;
                systemd.enable = false;
            };

            home.packages = lib.optional (cfg.uwsm.runner != null) cfg.uwsm.runner;
        })
    ];
}
