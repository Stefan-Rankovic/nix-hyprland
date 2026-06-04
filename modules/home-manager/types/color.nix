# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    forceNonNullIn,
    lib,
    mkNullOption,
}:

let
    inherit (lib) mkOption types;

    byte = types.ints.between 0 255;
    alpha = types.float // {
        check = value: types.float.check value && value >= 0.0 && value <= 1.0;
    };

    colorTypes = {
        rgb = types.submodule {
            options = {
                r = mkOption { type = byte; };
                g = mkOption { type = byte; };
                b = mkOption { type = byte; };
            };
        };
        rgba = types.submodule {
            options = {
                r = mkOption { type = byte; };
                g = mkOption { type = byte; };
                b = mkOption { type = byte; };
                a = mkOption { type = alpha; };
            };
        };
    };
in
forceNonNullIn (
    types.submodule {
        options = {
            rgb = mkNullOption {
                type = colorTypes.rgb;
            };
            rgba = mkNullOption {
                type = colorTypes.rgba;
            };
            raw = mkNullOption {
                type = types.str;
            };
        };
    }
)
