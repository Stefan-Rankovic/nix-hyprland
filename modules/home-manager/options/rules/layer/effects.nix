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
    no_anim = mkNullOption {
        type = types.bool;
        description = "Disables animations.";
    };

    blur = mkNullOption {
        type = types.bool;
        description = "Enables blur for the layer.";
    };

    blur_popups = mkNullOption {
        type = types.bool;
        description = "Enables blur for popups.";
    };

    ignore_alpha = mkNullOption {
        type = types.numbers.between 0 1;
        description = "Makes blur ignore pixels with opacity of `a` or lower..";
    };

    dim_around = mkNullOption {
        type = types.bool;
        description = "Dims everything behind the layer.";
    };

    xray = mkNullOption {
        type = types.bool;
        description = "Sets the blur xray mode for the layer.";
    };

    animation = mkNullOption {
        type = types.str;
        description = "Sets a specific animation style for this layer.";
    };

    order = mkNullOption {
        type = types.int;
        description = "Sets the order relative to other layers. Higher number = closer to edge of monitor. Can be negative.";
    };

    above_lock = mkNullOption {
        type = types.int;
        description = "If non-zero, renders the layer above the lockscreen. `2` = interactive on lockscreen.";
    };

    no_screen_share = mkNullOption {
        type = types.bool;
        description = "Hides the layer from screen sharing.";
    };
}
