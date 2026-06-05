# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs =
        { nixpkgs, ... }:
        let
            inherit (nixpkgs) lib;

            hyprlandVersion = "0.55.2";

            checkHyprlandVersion =
                pkg:
                if pkg.version == hyprlandVersion then
                    pkg
                else if lib.versionOlder pkg.version hyprlandVersion then
                    lib.warn "nix-hyprland: This version of nix-hyprland was made for Hyprland ${hyprlandVersion}. Your Hyprland version is older than that. Please update Hyprland or downgrade nix-hyprland." pkg
                else
                    lib.warn "nix-hyprland: This version of nix-hyprland was made for Hyprland ${hyprlandVersion}. Your Hyprland version is newer than that. Please update nix-hyprland or downgrade Hyprland." pkg;
        in
        {
            homeManagerModules.default = import ./modules/home-manager/default.nix checkHyprlandVersion;
            nixosModules.default = import ./modules/nixos/default.nix checkHyprlandVersion;
        };
}
