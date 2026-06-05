# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    checkHyprlandVersion,
    lib,
    pkgs,
    ...
}:

let
    inherit (lib) mkEnableOption types;
in
{

    options.nix-hyprland = {
        enable = mkEnableOption "nix-hyprland";
        package = lib.mkOption {
            type = types.package;
            default = pkgs.hyprland;
            description = "The hyprland package to use.";
            apply = checkHyprlandVersion;
        };
        uwsm.runner = lib.mkOption {
            type = types.nullOr types.package;
            default = null;
            example = pkgs.runapp;
            description = "The program runner to use. If don't want to use `uwsm app --`.";
        };
        xwayland.enable = mkEnableOption "XWayland" // {
            default = true;
        };
    };
}
