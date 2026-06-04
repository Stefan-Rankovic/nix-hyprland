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
    class = mkNullOption {
        type = localTypes.regex;
        description = "Windows with `class` matching `RegEx`.";
    };

    title = mkNullOption {
        type = localTypes.regex;
        description = "Windows with `title` matching `RegEx`.";
    };

    initial_class = mkNullOption {
        type = localTypes.regex;
        description = "Windows with `initialClass` matching `RegEx`.";
    };

    initial_title = mkNullOption {
        type = localTypes.regex;
        description = "Windows with `initialTitle` matching `RegEx`.";
    };

    tag = mkNullOption {
        type = types.str;
        description = "Windows with matching `tag`.";
    };

    xwayland = mkNullOption {
        type = types.bool;
        description = "Xwayland windows.";
    };

    float = mkNullOption {
        type = types.bool;
        description = "Floating windows.";
    };

    fullscreen = mkNullOption {
        type = types.bool;
        description = "Fullscreen windows.";
    };

    pin = mkNullOption {
        type = types.bool;
        description = "Pinned windows.";
    };

    focus = mkNullOption {
        type = types.bool;
        description = "Currently focused window.";
    };

    group = mkNullOption {
        type = types.bool;
        description = "Grouped windows.";
    };

    modal = mkNullOption {
        type = types.str;
        description = "Modal windows (e.g. \"Are you sure\" popups).";
    };

    fullscreen_state_client = mkNullOption {
        type = types.ints.between 0 3;
        description = ''
            Windows with matching `fullscreenstate`.
            - `0`: None.
            - `1`: Maximize.
            - `2`: Fullscreen.
            - `3`: Maximize and fullscreen.
        '';
    };

    fullscreen_state_internal = mkNullOption {
        type = types.ints.between 0 3;
        description = ''
            Windows with matching `fullscreenstate`.
            - `0`: None.
            - `1`: Maximize.
            - `2`: Fullscreen.
            - `3`: Maximize and fullscreen.
        '';
    };

    workspace = mkNullOption {
        type = types.str;
        description = "Windows on matching workspace. Can be `id`, `\"name:string\"` or a workspace selector.";
    };

    content = mkNullOption {
        type = localTypes.content_type;
        description = "Windows with specified content type.";
    };

    xdg_tag = mkNullOption {
        type = types.str;
        description = "Match a window by its xdgTag (see `hyprctl clients` to check if it has one).";
    };
}
