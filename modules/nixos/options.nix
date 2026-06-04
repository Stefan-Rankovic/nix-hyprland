# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
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
            apply =
                pkg:
                let
                    currentVersion = "0.55.0";
                in
                if pkg.version == currentVersion then
                    pkg
                else if lib.versionOlder pkg.version currentVersion then
                    lib.warn "nix-hyprland: This version of nix-hyprland was made for Hyprland ${currentVersion}. Your Hyprland version is older than that. Please update Hyprland or downgrade nix-hyprland." pkg
                else
                    lib.warn "nix-hyprland: This version of nix-hyprland was made for Hyprland ${currentVersion}. Your Hyprland version is newer than that. Please update nix-hyprland or downgrade Hyprland." pkg;
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
