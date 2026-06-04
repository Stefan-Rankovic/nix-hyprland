# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    localTypes,
    mkNullOption,
}:

let
    inherit (lib) types;
in
{
    transform = mkNullOption {
        type = types.ints.between (-1) 7;
        description = "Transform the input from tablets. The possible transformations are the same as those of the monitors. `-1` means it's unset.";
    };

    output = mkNullOption {
        type = types.str;
        description = "The monitor to bind tablets. Can be `\"current\"` or a monitor name. Leave empty to map across all monitors.";
    };

    region_position = mkNullOption {
        type = localTypes.vec2;
        description = "Position of the mapped region in monitor layout relative to the top left corner of the bound monitor or all monitors.";
    };

    absolute_region_position = mkNullOption {
        type = types.bool;
        description = "Whether to treat the `region_position` as an absolute position in monitor layout. Only applies when `output` is empty.";
    };

    region_size = mkNullOption {
        type = localTypes.vec2;
        description = "Size of the mapped region. When this variable is set, tablet input will be mapped to the region. `{0, 0}` or invalid size means unset.";
    };

    relative_input = mkNullOption {
        type = types.bool;
        description = "Whether the input should be relative.";
    };

    left_handed = mkNullOption {
        type = types.bool;
        description = "If enabled, the tablet will be rotated 180 degrees.";
    };

    active_area_size = mkNullOption {
        type = localTypes.vec2;
        description = "Size of tablet's active area in mm.";
    };

    active_area_position = mkNullOption {
        type = localTypes.vec2;
        description = "Position of the active area in mm.";
    };
}
