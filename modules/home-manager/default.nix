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

    cfg = config.programs.nix-hyprland;

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

    # todo: refactor these two functions when types.addCheck is fixed, on https://github.com/NixOS/nixpkgs/issues/396021. This should work too but addCheck is way cleaner.
    nonNullSubmodule =
        args:
        let
            base = types.submodule args;
        in
        base
        // {
            merge =
                location: definitions:
                let
                    merged = base.merge location definitions;
                in
                lib.throwIf (lib.all (v: v == null) (
                    lib.attrValues merged
                )) "Option `${lib.showOption location}` requires at least one non-null value" merged;
        };
    xNonNullSubmodule =
        expectedNonNullAmount: args:
        let
            base = types.submodule args;
        in
        base
        // {
            merge =
                location: definitions:
                let
                    merged = base.merge location definitions;
                    nonNulls = lib.filterAttrs (_: val: val != null) merged;
                    nonNullAmount = lib.length (lib.attrValues nonNulls);
                in
                lib.throwIf (nonNullAmount != expectedNonNullAmount)
                    "Option `${lib.showOption location}` requires exactly ${toString expectedNonNullAmount} non-null value${
                        if expectedNonNullAmount != 1 then "s" else "" # Grammar
                    }, got ${toString nonNullAmount}"
                    merged;
        };

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
                    cfg
                    checkHyprlandVersion
                    doubleElement
                    localTypes
                    luaFunctionArguments
                    mkNullOption
                    mkNullSubmodule
                    nonNullSubmodule
                    xNonNullSubmodule
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
