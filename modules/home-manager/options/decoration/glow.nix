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
    enabled = mkNullOption {
        type = types.bool;
        description = "Enable inner glow on windows.";
    };

    range = mkNullOption {
        type = types.ints.positive;
        description = "Glow range (\"size\") in layout px.";
    };

    render_power = mkNullOption {
        type = types.ints.between 1 4;
        description = "In what power to render the falloff (more power, the faster the falloff).";
    };

    color = mkNullOption {
        type = localTypes.color;
        description = "Glow's color. Alpha dictates glow's opacity.";
    };

    color_inactive = mkNullOption {
        type = localTypes.color;
        description = "Inactive glow color (if not set, will fall back to `color`).";
    };
}
