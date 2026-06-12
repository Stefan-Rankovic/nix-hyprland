# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    checkHyprlandVersion,
    lib,
    pkgs,
    ...
}:

let
    inherit (lib) mkEnableOption mkOption types;
in
{

    options.nix-hyprland = {
        enable = mkEnableOption "nix-hyprland";
        package = mkOption {
            type = types.package;
            default = pkgs.hyprland;
            description = "The hyprland package to use.";
            apply = checkHyprlandVersion;
        };
        portalPackage = mkOption {
            type = types.package;
            default = pkgs.xdg-desktop-portal-hyprland;
            description = "The xdg-desktop-portal-hyprland package to use.";
        };
        uwsm.runner = mkOption {
            type = types.nullOr types.package;
            default = null;
            example = pkgs.runapp;
            description = "The program runner to use. If don't want to use `uwsm app --`.";
        };
    };
}
