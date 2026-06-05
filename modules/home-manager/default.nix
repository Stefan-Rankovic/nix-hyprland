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
        # {
        #     type,
        #     description ? "",
        # }:
        # assert !(lib.hasPrefix "null or" type.name);
        # lib.mkOption {
        #     default = null;
        #     type = types.nullOr type;
        #     inherit description;
        # };
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

    forceNonNullIn =
        type: types.addCheck type (attrs: builtins.any (v: v != null) (builtins.attrValues attrs));

    exactlyOneNonNullSubmodule =
        module:
        types.submodule (
            { config, ... }:
            {
                inherit (module) options;
                config._module.check =
                    builtins.length (lib.filter (v: v != null) (builtins.attrValues config)) == 1;
                # config._module.check = [
                #     (
                #         let
                #             nonNullCount = builtins.length (lib.filter (v: v != null) (builtins.attrValues config));
                #         in
                #         if nonNullCount == 1 then
                #             null
                #         else
                #             "Exactly one field must be non-null, but got ${toString nonNullCount}"
                #     )
                # ];
            }
        );

    doubleElement = elementType: types.addCheck (types.listOf elementType) (v: builtins.length v == 2);

    luaFunctionArguments =
        list: builtins.concatStringsSep ", " (map (value: lib.generators.toLua { } value) list);

    localTypes = import ./types {
        inherit
            doubleElement
            forceNonNullIn
            lib
            mkNullOption
            ;
    };
in
{
    _module.args = {
        inherit
            doubleElement
            exactlyOneNonNullSubmodule
            checkHyprlandVersion
            forceNonNullIn
            localTypes
            luaFunctionArguments
            mkNullOption
            mkNullSubmodule
            ;
    };

    imports = [
        ./apply
        ./options
    ];

    xdg.portal = {
        inherit (cfg.xdg_portal) enable;
        extraPortals = builtins.attrValues cfg.xdg_portal.extraPortals;
        config.common.default = builtins.attrNames cfg.xdg_portal.extraPortals;
    };

    wayland.windowManager.hyprland = {
        inherit (cfg)
            enable
            package
            xwayland
            ;
        systemd.enable = false;
        portalPackage = cfg.xdg_portal.package;
    };
    home.packages = lib.optional (cfg.enable && (cfg.uwsm.runner != null)) cfg.uwsm.runner;
}
