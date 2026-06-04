# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    doubleElement,
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
    ...
}:

let
    inherit (lib) mkOption types;
in
{
    persistent_size = mkNullOption {
        type = types.bool;
        description = "For floating windows, internally store their size. When a new floating window opens with the same class and title, restore the saved size.";
    };

    no_max_size = mkNullOption {
        type = types.bool;
        description = "Removes max size limitations.";
    };

    stay_focused = mkNullOption {
        type = types.bool;
        description = "Forces focus on the window as long as it’s visible.";
    };

    animation = mkNullOption {
        type = types.str; # todo: maybe make custom type?
        description = "Forces an animation onto a window with an optional style. E.g. `\"popin\"` or `\"popin 80%\"`.";
    };

    border_color = mkNullOption {
        type = types.either localTypes.gradient (doubleElement localTypes.gradient);
        description = "Force the border color.";
    };

    idle_inhibit = mkNullOption {
        type = localTypes.idle_inhibit_rules;
        description = "Sets an idle inhibit rule.";
    };

    opacity = mkNullOption {
        type = localTypes.opacity;
        description = "Additional opacity multiplier.";
    };

    tag = mkNullSubmodule {
        options = {
            mode = mkNullOption {
                type = types.enum [
                    "set"
                    "unset"
                    "toggle"
                ];
            };
            name = mkOption { type = types.str; };
        };
        description = "Applies a tag.";
    };

    max_size = mkNullOption {
        type = localTypes.vec2;
        description = "Sets the maximum size for floating windows. E.g. `{ 800, 600 }`.";
    };

    min_size = mkNullOption {
        type = localTypes.vec2;
        description = "Sets the minimum size for floating windows. E.g. `{ 200, 150 }`.";
    };

    border_size = mkNullOption {
        type = types.ints.unsigned;
        description = "Sets the border size.";
    };

    rounding = mkNullOption {
        type = types.ints.unsigned;
        description = "Forces X pixels of rounding, ignoring the default.";
    };

    rounding_power = mkNullOption {
        type = types.ints.positive;
        description = "Overrides the rounding power for the window.";
    };

    allows_input = mkNullOption {
        type = types.bool;
        description = "Forces an XWayland window to receive input even if it requests not to.";
    };

    dim_around = mkNullOption {
        type = types.bool;
        description = "Dims everything around the window. Meant for floating windows.";
    };

    decorate = mkNullOption {
        type = types.bool;
        description = "Whether to draw window decorations.";
    };

    focus_on_activate = mkNullOption {
        type = types.bool;
        description = "Whether Hyprland should focus an app that requests to be focused.";
    };

    keep_aspect_ratio = mkNullOption {
        type = types.bool;
        description = "Forces aspect ratio when resizing with the mouse.";
    };

    nearest_neightbor = mkNullOption {
        type = types.bool;
        description = "Forces nearest-neighbor filtering.";
    };

    no_anim = mkNullOption {
        type = types.bool;
        description = "Disables animations for the window.";
    };

    no_blur = mkNullOption {
        type = types.bool;
        description = "Disables blur for the window.";
    };

    no_dim = mkNullOption {
        type = types.bool;
        description = "Disables window dimming for the window.";
    };

    no_focus = mkNullOption {
        type = types.bool;
        description = "Disables focus to the window.";
    };

    no_follow_mouse = mkNullOption {
        type = types.bool;
        description = "Prevents the window from being focused when the mouse moves over it when input.follow_mouse=1 is set.";
    };

    no_shadow = mkNullOption {
        type = types.bool;
        description = "Disables shadows for the window.";
    };

    no_shortcuts_inhibit = mkNullOption {
        type = types.bool;
        description = "Disables the app from inhibiting your shortcuts.";
    };

    no_screen_share = mkNullOption {
        type = types.bool;
        description = "Hides the window and its popups from screen sharing by drawing black rectangles in their place.";
    };

    no_vrr = mkNullOption {
        type = types.bool;
        description = "Disables VRR for the window. Only works when `misc.vrr` is set to `2` or `3`.";
    };

    no_auto_hdr = mkNullOption {
        type = types.bool;
        description = "Disables AutoHDR for the window. This is useful to stop programs like `foot` triggering AutoHDR when they are fullscreened.";
    };

    opaque = mkNullOption {
        type = types.bool;
        description = "Forces the window to be opaque.";
    };

    force_rgbx = mkNullOption {
        type = types.bool;
        description = "Forces Hyprland to ignore the alpha channel entirely.";
    };

    sync_fullscreen = mkNullOption {
        type = types.bool;
        description = "Whether the fullscreen mode should always be the same as the one sent to the window.";
    };

    immediate = mkNullOption {
        type = types.bool;
        description = "Forces the window to allow tearing.";
    };

    xray = mkNullOption {
        type = types.bool;
        description = "Sets blur xray mode for the window.";
    };

    render_unfocused = mkNullOption {
        type = types.bool;
        description = "Forces the window to think it’s being rendered when it’s not visible.";
    };

    scroll_mouse = mkNullOption {
        type = types.bool;
        description = "Forces the window to override `input.scroll_factor`.";
    };

    scroll_touchpad = mkNullOption {
        type = types.bool;
        description = "Forces the window to override `input.touchpad.scroll_factor`.";
    };

    confine_pointer = mkNullOption {
        type = types.bool;
        description = "Locks the mouse cursor to the window. Mostly useful for keeping your mouse cursor locked to one monitor during gaming.";
    };
}
