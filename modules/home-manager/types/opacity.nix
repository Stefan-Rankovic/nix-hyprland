# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{ lib }:

let
    inherit (lib) mkOption types;
    opacityPartType = types.submodule {
        options = {
            value = mkOption {
                type = types.numbers.between 0 1;
                default = 1.0;
            };
            override = mkOption {
                type = types.bool;
                default = false;
            };
        };
    };
in
types.submodule {
    options = {
        active = mkOption { type = opacityPartType; };
        inactive = mkOption { type = opacityPartType; };
        fullscreen = mkOption { type = opacityPartType; };
    };
}
