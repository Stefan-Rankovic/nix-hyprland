# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = _: {
        homeManagerModules.default = import ./modules/home-manager/default.nix;
        nixosModules.default = import ./modules/nixos/default.nix;
    };
}
