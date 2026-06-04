# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    mkNullOption,
}:

let
    inherit (lib) types;
in
{
    transform = mkNullOption {
        type = types.ints.between (-1) 7;
        description = "Transform the input from touchdevices. The possible transformations are the same as [those of the monitors](https://wiki.hypr.land/Configuring/Basics/Monitors/#rotating). `-1` means it’s unset.";
    };

    output = mkNullOption {
        type = types.str;
        description = "The monitor to bind touch devices. The default is auto-detection. To stop auto-detection, use an empty string.";
    };

    enabled = mkNullOption {
        type = types.bool;
        description = "Whether input is enabled for touch devices.";
    };
}
