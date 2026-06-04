# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
}:

let
    inherit (lib) types;
in
{
    blur = mkNullSubmodule {
        options = import ./blur.nix { inherit lib mkNullOption; };
    };
    glow = mkNullSubmodule {
        options = import ./glow.nix { inherit lib localTypes mkNullOption; };
    };
    shadow = mkNullSubmodule {
        options = import ./shadow.nix { inherit lib localTypes mkNullOption; };
    };

    rounding = mkNullOption {
        type = types.ints.unsigned;
        description = "Rounded corners' radius (in layout px).";
    };

    rounding_power = mkNullOption {
        type = types.numbers.between 1 10;
        description = "Adjusts the curve used for rounding corners, larger is smoother, `2.0` is a circle, `4.0` is a squircle, `1.0` is a triangular corner.";
    };

    active_opacity = mkNullOption {
        type = types.numbers.between 0 1;
        description = "Opacity of active windows.";
    };

    inactive_opacity = mkNullOption {
        type = types.numbers.between 0 1;
        description = "Opacity of inactive windows.";
    };

    fullscreen_opacity = mkNullOption {
        type = types.numbers.between 0 1;
        description = "Opacity of fullscreen windows.";
    };

    dim_modal = mkNullOption {
        type = types.bool;
        description = "Enables dimming of parents of modal windows.";
    };

    dim_inactive = mkNullOption {
        type = types.bool;
        description = "Enables dimming of inactive windows.";
    };

    dim_strength = mkNullOption {
        type = types.numbers.between 0 1;
        description = "How much inactive windows should be dimmed.";
    };

    dim_special = mkNullOption {
        type = types.numbers.between 0 1;
        description = "How much to dim the rest of the screen by when a special workspace is open.";
    };

    dim_around = mkNullOption {
        type = types.numbers.between 0 1;
        description = "How much the `dim_around` window rule should dim by.";
    };

    screen_shader = mkNullOption {
        type = types.path;
        description = "A path to a custom shader to be applied at the end of rendering. See [examples/screenShader.frag](https://github.com/hyprwm/Hyprland/blob/main/example/screenShader.frag) for an example.";
    };

    border_part_of_window = mkNullOption {
        type = types.bool;
        description = "Whether the window border should be a part of the window.";
    };
}
