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
    enabled = mkNullOption {
        type = types.bool;
        description = "Enable kawase window background blur.";
    };

    size = mkNullOption {
        type = types.ints.positive;
        description = "Blur size (distance).";
    };

    passes = mkNullOption {
        type = types.ints.positive;
        description = "The amount of passes to perform.";
    };

    ignore_opacity = mkNullOption {
        type = types.bool;
        description = "Make the blur layer ignore the opacity of the window.";
    };

    new_optimizations = mkNullOption {
        type = types.bool;
        description = "Make the blur layer ignore the opacity of the window.";
    };

    xray = mkNullOption {
        type = types.bool;
        description = "If enabled, floating windows will ignore tiled windows in their blur. Only available if `new_optimizations` is true. Will reduce overhead on floating blur significantly.";
    };

    noise = mkNullOption {
        type = types.numbers.between 0 1;
        description = "How much noise to apply.";
    };

    contrast = mkNullOption {
        type = types.numbers.between 0 2;
        description = "Contrast modulation for blur.";
    };

    brightness = mkNullOption {
        type = types.numbers.between 0 2;
        description = "Brightness modulation for blur.";
    };

    vibrancy = mkNullOption {
        type = types.numbers.between 0 1;
        description = "Increase saturation of blurred colors.";
    };

    vibrancy_darkness = mkNullOption {
        type = types.numbers.between 0 1;
        description = "How strong the effect of vibrancy is on dark areas.";
    };

    special = mkNullOption {
        type = types.bool;
        description = "Whether to blur behind the special workspace (note: expensive).";
    };

    popups = mkNullOption {
        type = types.bool;
        description = "Whether to blur popups (e.g. right-click menus).";
    };

    popups_ignorealpha = mkNullOption {
        type = types.numbers.between 0 1;
        description = "Works like ignore_alpha in layer rules. If pixel opacity is below set value, will not blur.";
    };

    input_methods = mkNullOption {
        type = types.bool;
        description = "Whether to blur input methods (e.g. fcitx5).";
    };

    input_ignorealpha = mkNullOption {
        type = types.numbers.between 0 1;
        description = "Works like `ignore_alpha` in layer rules. If pixel opacity is below set value, will not blur.";
    };
}
