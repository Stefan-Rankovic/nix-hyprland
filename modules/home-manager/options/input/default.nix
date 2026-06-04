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
    tablet = mkNullSubmodule {
        options = import ./tablet.nix { inherit lib localTypes mkNullOption; };
    };
    tablettool = mkNullSubmodule {
        options = import ./tablettool.nix { inherit lib mkNullOption; };
    };
    touchdevice = mkNullSubmodule {
        options = import ./touchdevice.nix { inherit lib mkNullOption; };
    };
    touchpad = mkNullSubmodule {
        options = import ./touchpad.nix { inherit lib mkNullOption; };
    };
    virtualkeyboard = mkNullSubmodule {
        options = import ./virtualkeyboard.nix { inherit lib mkNullOption; };
    };

    kb_model = mkNullOption {
        type = types.str;
        description = ''
            Appropriate XKB keymap parameter.

            You can find a list of models, layouts, variants and options in `/usr/share/X11/xkb/rules/evdev.lst`. Alternatively, you can use the `localectl` command to discover what is available on your system.'';
    };

    kb_layout = mkNullOption {
        type = types.str;
        description = ''
            Appropriate XKB keymap parameter.

            You can find a list of models, layouts, variants and options in `/usr/share/X11/xkb/rules/evdev.lst`. Alternatively, you can use the `localectl` command to discover what is available on your system.'';
    };

    kb_variant = mkNullOption {
        type = types.str;
        description = ''
            Appropriate XKB keymap parameter.

            You can find a list of models, layouts, variants and options in `/usr/share/X11/xkb/rules/evdev.lst`. Alternatively, you can use the `localectl` command to discover what is available on your system.'';
    };

    kb_options = mkNullOption {
        type = types.str;
        description = ''
            Appropriate XKB keymap parameter.

            You can find a list of models, layouts, variants and options in `/usr/share/X11/xkb/rules/evdev.lst`. Alternatively, you can use the `localectl` command to discover what is available on your system.'';
    };

    kb_rules = mkNullOption {
        type = types.str;
        description = ''
            Appropriate XKB keymap parameter.

            You can find a list of models, layouts, variants and options in `/usr/share/X11/xkb/rules/evdev.lst`. Alternatively, you can use the `localectl` command to discover what is available on your system.'';
    };

    kb_file = mkNullOption {
        type = types.path;
        description = "If you prefer, you can use a path to your custom .xkb file.";
    };

    numlock_by_default = mkNullOption {
        type = types.bool;
        description = "Engage numlock by default.";
    };

    resolve_binds_by_sym = mkNullOption {
        type = types.bool;
        description = "Determines how keybinds act when multiple layouts are used. If `false`, keybinds will always act as if the first specified layout is active. If `true`, keybinds specified by symbols are activated when you type the respective symbol with the current layout.";
    };

    repeat_rate = mkNullOption {
        type = types.ints.positive;
        description = "The repeat rate for held-down keys, in repeats per second.";
    };

    repeat_delay = mkNullOption {
        type = types.ints.positive;
        description = "Delay before a held-down key is repeated, in milliseconds.";
    };

    sensitivity = mkNullOption {
        type = types.numbers.between (-1.0) 1.0;
        description = "Sets the mouse input sensitivity.";
    };

    accel_profile = mkNullOption {
        type = types.enum [
            "adaptive"
            "flat"
            "custom"
        ];
        description = ''
            Sets the cursor acceleration profile. Leave empty to use `libinput`'s default mode for your input device.

            ## Custom Accel Profiles

            ### accel_profile
            `custom <step> <points...>`
            Example: `custom 200 0.0 0.5`

            ### scroll_points

            NOTE: Only works when `accel_profile` is set to `custom`.

            `<step> <points...>`

            Example: `0.2 0.0 0.5 1 1.2 1.5`

            To mimic the Windows acceleration curves, take a look at [this script](https://gist.github.com/fufexan/de2099bc3086f3a6c83d61fc1fcc06c9).

            See [the libinput doc](https://wayland.freedesktop.org/libinput/doc/latest/pointer-acceleration.html) for more insights on how it works.
        '';
    };

    force_no_accel = mkNullOption {
        type = types.bool;
        description = "Force no cursor acceleration. This bypasses most of your pointer settings to get as raw of a signal as possible. **Enabling this is not recommended due to potential cursor desynchronization.**";
    };

    rotation = mkNullOption {
        type = types.ints.between 0 359;
        description = "Sets the rotation of a device in degrees clockwise off the logical neutral position.";
    };

    left_handed = mkNullOption {
        type = types.bool;
        description = "Switches RMB and LMB.";
    };

    scroll_points = mkNullOption {
        type = types.str;
        description = "Sets the scroll acceleration profile, when `accel_profile` is set to `\"custom\"`. Has to be in the form `\"<step> <points>\"`. Leave empty to have a flat scroll curve.";
    };

    scroll_method = mkNullOption {
        type = types.enum [
            "2fg" # 2 fingers
            "edge"
            "on_button_down"
            "no_scroll"
        ];
        description = "Sets the scroll method.";
    };

    scroll_button = mkNullOption {
        type = types.ints.unsigned;
        description = "Sets the scroll button. Check `wev` if you have any doubts regarding the ID. 0 means default.";
    };

    scroll_button_lock = mkNullOption {
        type = types.bool;
        description = "If the scroll button lock is enabled, the button does not need to be held down. Pressing and releasing the button toggles the button lock, which logically holds the button down or releases it. While the button is logically held down, motion events are converted to scroll events.";
    };

    scroll_factor = mkNullOption {
        type = types.float;
        description = "Multiplier added to scroll movement for external mice. Note that there is a separate setting for [touchpad scroll_factor](https://wiki.hypr.land/Configuring/Basics/Variables/#touchpad).";
    };

    natural_scroll = mkNullOption {
        type = types.bool;
        description = "Inverts scrolling direction. When enabled, scrolling moves content directly, rather than manipulating a scrollbar.";
    };

    follow_mouse = mkNullOption {
        type = types.ints.between 0 3;
        description = ''
            Specify if and how cursor movement should affect window focus.
            - `0`: Cursor movement will not change focus.
            - `1`: Cursor movement will always change focus to the window under the cursor.
            - `2`: Cursor focus will be detached from keyboard focus. Clicking on a window will move keyboard focus to that window.
            - `3`: Cursor focus will be completely separate from keyboard focus. Clicking on a window will not change keyboard focus.
        '';
    };

    follow_mouse_shrink = mkNullOption {
        type = types.ints.unsigned;
        description = "Shrinks the inactive window hitboxes used for focus detection by the specified number of pixels. This creates a dead zone in gaps between windows where moving the cursor will not change focus. Works only with `follow_mouse = 1`.";
    };

    follow_mouse_threshold = mkNullOption {
        type = types.float;
        description = "The smallest distance in logical pixels the mouse needs to travel for the window under it to get focused. Works only with `follow_mouse = 1`.";
    };

    focus_on_close = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            Controls the window focus behavior when a window is closed.
            - `0`: Focus will shift to the next window candidate.
            - `1`: Focus will shift to the window under the cursor.
            - `2`: Focus will shift to the most recently used/active window.'';
    };

    mouse_refocus = mkNullOption {
        type = types.bool;
        description = "If disabled, mouse focus won't switch to the hovered window unless the cursor crosses a window boundary when `follow_mouse = 1`.";
    };

    float_switch_override_focus = mkNullOption {
        type = types.ints.between 0 2;
        description = "If enabled (1 or 2), focus will change to the window under the cursor when changing from tiled-to-floating and vice versa. If 2, focus will also follow mouse on float-to-float switches.";
    };

    special_fallthrough = mkNullOption {
        type = types.bool;
        description = "If enabled, having only floating windows in the special workspace will not block focusing windows in the regular workspace.";
    };

    off_window_axis_events = mkNullOption {
        type = types.ints.between 0 3;
        description = ''
            Handles axis events around (gaps/border for tiled, dragarea/border for floated) a focused window.
            - `0`: Ignores axis events.
            - `1`: Sends out-of-bound coordinates.
            - `2`: Fakes pointer coordinates to the closest point inside the window.
            - `3`: Warps the cursor to the closest point inside the window.'';
    };

    emulate_discrete_scroll = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            Emulates discrete scrolling from high resolution scrolling events.
            - `0`: Disables it.
            - `1`: Enables handling of non-standard events only.
            - `2`: Force enables all scroll wheel events to be handled.'';
    };
}
