# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    checkHyprlandVersion,
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
    pkgs,
    ...
}:

let
    inherit (lib) mkOption types;
in
{
    imports = [
        ./binds
        ./dispatchers
        ./monitors.nix
        ./rules
    ];

    options.nix-hyprland = {
        enable = lib.mkEnableOption "nix-hyprland";
        package = mkNullOption {
            type = types.package;
            example = pkgs.hyprland;
            description = "The hyprland package to use. If you use the nixos module, don't change this. Otherwise, set it.";
            apply = pkg: if pkg == null then pkg else checkHyprlandVersion pkg;
        };
        xdg_portal = {
            enable = lib.mkEnableOption "XDG portal and integrate it with Hyprland";
            package = mkOption {
                type = types.nullOr types.package;
                default = pkgs.xdg-desktop-portal-hyprland;
                description = "The xdg-desktop-portal-hyprland package to use.";
            };
            extraPortals = mkOption {
                type = types.attrsOf types.package;
                default = with pkgs; {
                    hyprland = xdg-desktop-portal-hyprland;
                };
                example = with pkgs; {
                    hyprland = xdg-desktop-portal-hyprland;
                    gtk = xdg-desktop-portal-gtk;
                };
                description = "Additional portals that should be added to the environment.";
            };
        };
        uwsm.runner = mkNullOption {
            type = types.package;
            example = pkgs.runapp;
            description = "The program runner to use. If you don't want to use `uwsm app --`.";
        };
        xwayland.enable =
            lib.mkEnableOption "XWayland (this option overrides the one defined in the nixos module)"
            // {
                default = true;
            };

        extraLuaConfigPre = mkOption {
            type = types.str;
            default = "";
            description = "Lua configuration to be put at the top of hyprland.lua";
        };
        extraLuaConfigPost = mkOption {
            type = types.str;
            default = "";
            description = "Lua configuration to be put at the bottom of hyprland.lua";
        };

        decoration = mkNullSubmodule {
            options = import ./decoration {
                inherit
                    lib
                    localTypes
                    mkNullOption
                    mkNullSubmodule
                    ;
            };
        };
        general = mkNullSubmodule {
            options = import ./general {
                inherit
                    lib
                    localTypes
                    mkNullOption
                    mkNullSubmodule
                    ;
            };
        };
        group = mkNullSubmodule {
            options = import ./group {
                inherit
                    lib
                    localTypes
                    mkNullOption
                    mkNullSubmodule
                    ;
            };
        };
        input = mkNullSubmodule {
            options = import ./input {
                inherit
                    lib
                    localTypes
                    mkNullOption
                    mkNullSubmodule
                    ;
            };
        };

        animations = mkNullSubmodule {
            options = import ./animations.nix { inherit lib mkNullOption; };
        };
        cursor = mkNullSubmodule {
            options = import ./cursor.nix { inherit lib mkNullOption; };
        };
        debug = mkNullSubmodule {
            options = import ./debug.nix { inherit lib mkNullOption; };
        };
        ecosystem = mkNullSubmodule {
            options = import ./ecosystem.nix { inherit lib mkNullOption; };
        };
        gestures = mkNullSubmodule {
            options = import ./gestures.nix { inherit lib mkNullOption; };
        };
        layout = mkNullSubmodule {
            options = import ./layout.nix { inherit lib mkNullOption; };
        };
        misc = mkNullSubmodule {
            options = import ./misc.nix {
                inherit
                    lib
                    localTypes
                    mkNullOption
                    mkNullSubmodule
                    ;
            };
        };
        opengl = mkNullSubmodule {
            options = import ./opengl.nix { inherit lib mkNullOption; };
        };
        quirks = mkNullSubmodule {
            options = import ./quirks.nix { inherit lib mkNullOption; };
        };
    };
}
