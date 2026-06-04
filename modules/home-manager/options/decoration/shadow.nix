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
        description = "Enable drop shadows on windows.";
    };

    range = mkNullOption {
        type = types.ints.positive;
        description = "Shadow range (\"size\") in layout px.";
    };

    render_power = mkNullOption {
        type = types.ints.between 1 4;
        description = "In what power to render the falloff (more power, the faster the falloff).";
    };

    sharp = mkNullOption {
        type = types.bool;
        description = "If enabled, will make the shadows sharp, akin to an infinite render power.";
    };

    color = mkNullOption {
        type = localTypes.color;
        description = "Shadow's color. Alpha dictates shadow's opacity.";
    };

    color_inactive = mkNullOption {
        type = localTypes.color;
        description = "Inactive shadow color (if not set, will fall back to `color`).";
    };

    offset = mkNullOption {
        type = localTypes.vec2;
        description = "Shadow's rendering offset.";
    };

    scale = mkNullOption {
        type = types.numbers.between 0 1;
        description = "Shadow's scale.";
    };
}
