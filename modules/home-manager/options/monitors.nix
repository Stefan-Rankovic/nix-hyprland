# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    localTypes,
    mkNullOption,
    ...
}:

let
    inherit (lib) mkOption types;

    monitorType = types.submodule {
        options = {
            output = mkOption {
                type = types.str;
                description = "Output name or `desc:...` description prefix.";
            };
            mode = mkNullOption {
                type = types.str;
                description = "Resolution and refresh rate, e.g. `1920x1080@144`.";
            };
            position = mkNullOption {
                type = types.str;
                description = "Position in the virtual layout, e.g. `1920x1080`.";
            };
            scale = mkNullOption {
                type = types.float;
                description = "Scale factor, e.g. `1.5`.";
            };
            disabled = mkNullOption {
                type = types.bool;
                description = "Removes the monitor from the layout.";
            };
            transform = mkNullOption {
                type = types.ints.between 0 7;
                description = "Rotation/flip transform.";
            };
            mirror = mkNullOption {
                type = types.str;
                description = "Output name to mirror.";
            };
            bitdepth = mkNullOption {
                type = types.enum [
                    8
                    10
                ];
                description = "Bit depth.";
            };
            cm = mkNullOption {
                type = types.str;
                description = "Color management preset.";
            };
            sdr_eotf = mkNullOption {
                type = types.enum [
                    "default"
                    "gamma22"
                    "srgb"
                ];
                description = "SDR transfer function.";
            };
            sdrbrightness = mkNullOption {
                type = types.float;
                description = "SDR brightness in HDR mode.";
            };
            sdrsaturation = mkNullOption {
                type = types.float;
                description = "SDR saturation in HDR mode.";
            };
            vrr = mkNullOption {
                type = localTypes.vrr_mode;
                description = "VRR mode.";
            };
            icc = mkNullOption {
                type = types.path;
                description = "Absolute path to an ICC profile.";
            };
            reserved_area = mkNullOption {
                type = types.either types.int (
                    types.submodule {
                        options = {
                            left = mkNullOption { type = types.int; };
                            bottom = mkNullOption { type = types.int; };
                            top = mkNullOption { type = types.int; };
                            right = mkNullOption { type = types.int; };
                        };
                    }
                );
                description = "Reserved area - integer for all sides, or table with top/right/bottom/left.";
            };
            supports_wide_color = mkNullOption {
                type = types.enum [
                    (-1)
                    0
                    1
                ];
                description = ''
                    Force wide color gamut.
                    - `-1`: Off.
                    - `0`: Auto.
                    - `1`: On.
                '';
            };
            supports_hdr = mkNullOption {
                type = types.enum [
                    (-1)
                    0
                    1
                ];
                description = ''
                    Force HDR support.
                    - `-1`: Off.
                    - `0`: Auto.
                    - `1`: On.
                '';
            };
            sdr_min_luminance = mkNullOption {
                type = types.float;
                description = "SDR minimum luminance for SDR→HDR mapping.";
            };
            sdr_max_luminance = mkNullOption {
                type = types.int;
                description = "SDR maximum luminance.";
            };
            min_luminance = mkNullOption {
                type = types.float;
                description = "Monitor minimum luminance.";
            };
            max_luminance = mkNullOption {
                type = types.int;
                description = "Monitor maximum luminance.";
            };
            max_avg_luminance = mkNullOption {
                type = types.int;
                description = "Monitor maximum average luminance.";
            };
        };
    };
in
{
    options.programs.nix-hyprland.monitors = mkOption {
        type = types.listOf monitorType;
        default = [ ];
        description = "The monitors. See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Monitors/).";
    };
}
