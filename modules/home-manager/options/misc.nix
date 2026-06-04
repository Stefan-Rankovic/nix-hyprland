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
    disable_hyprland_logo = mkNullOption {
        type = types.bool;
        description = "Disables the random Hyprland logo / anime girl background. :(";
    };

    disable_splash_rendering = mkNullOption {
        type = types.bool;
        description = "Disables the Hyprland splash rendering. (requires a monitor reload to take effect)";
    };

    disable_scale_notification = mkNullOption {
        type = types.bool;
        description = "Disables notification popup when a monitor fails to set a suitable scale.";
    };

    col = mkNullSubmodule {
        options.splash = mkNullOption {
            type = localTypes.color;
            description = "Changes the color of the splash text (requires a monitor reload to take effect).";
        };
    };

    font_family = mkNullOption {
        type = types.str;
        description = "Set the global default font to render the text including debug fps/notification, config error messages and etc., selected from system fonts.";
    };

    splash_font_family = mkNullOption {
        type = types.str;
        description = "Changes the font used to render the splash text, selected from system fonts (requires a monitor reload to take effect).";
    };

    force_default_wallpaper = mkNullOption {
        type = types.ints.between (-1) 2;
        description = "Enforce any of the 3 default wallpapers. Setting this to `0` or `1` disables the anime background. `-1` means \"random\".";
    };

    vrr = mkNullOption {
        type = localTypes.vrr_mode;
        description = ''
            Controls the VRR (Adaptive Sync) of your monitors.
            - `0`: Off.
            - `1`: On.
            - `2`: Fullscreen only
            - `3`: Fullscreen with `video` or `game` content type.
        '';
    };

    mouse_move_enables_dpms = mkNullOption {
        type = types.bool;
        description = "If DPMS is set to off, wake up the monitors if the mouse moves.";
    };

    key_press_enables_dpms = mkNullOption {
        type = types.bool;
        description = "If DPMS is set to off, wake up the monitors if a key is pressed.";
    };

    name_vk_after_proc = mkNullOption {
        type = types.bool;
        description = "Name virtual keyboards after the processes that create them. E.g. `/usr/bin/fcitx5` will have `hl-virtual-keyboard-fcitx5`.";
    };

    always_follow_on_dnd = mkNullOption {
        type = types.bool;
        description = "Will make mouse focus follow the mouse when drag and dropping. Recommended to leave it enabled, especially for people using focus follows mouse at 0.";
    };

    layers_hog_keyboard_focus = mkNullOption {
        type = types.bool;
        description = "If true, will make keyboard-interactive layers keep their focus on mouse move (e.g. `wofi`, `bemenu`).";
    };

    animate_manual_resizes = mkNullOption {
        type = types.bool;
        description = "If true, will animate manual window resizes/moves.";
    };

    animate_mouse_windowdragging = mkNullOption {
        type = types.bool;
        description = "If true, will animate windows being dragged by mouse, note that this can cause weird behavior on some curves.";
    };

    disable_autoreload = mkNullOption {
        type = types.bool;
        description = "If true, the config will not reload automatically on save, and instead needs to be reloaded with `hyprctl reload`. Might save on battery.";
    };

    enable_swallow = mkNullOption {
        type = types.bool;
        description = "Enable window swallowing.";
    };

    swallow_regex = mkNullOption {
        type = types.str;
        description = "The class regex to be used for windows that should be swallowed (usually, a terminal). To know more about the list of regex which can be used use [this cheatsheet](https://github.com/ziishaned/learn-regex/blob/master/README.md).";
    };

    swallow_exception_regex = mkNullOption {
        type = types.str;
        description = "The title regex to be used for windows that should not be swallowed by the windows specified in swallow_regex (e.g. `wev`). The regex is matched against the parent (e.g. `Kitty`) window's title on the assumption that it changes to whatever process it's running.";
    };

    focus_on_activate = mkNullOption {
        type = types.bool;
        description = "Whether Hyprland should focus an app that requests to be focused (an `activate` request).";
    };

    mouse_move_focuses_monitor = mkNullOption {
        type = types.bool;
        description = "Whether mouse moving into a different monitor should focus it.";
    };

    allow_session_lock_restore = mkNullOption {
        type = types.bool;
        description = "If `true`, will allow you to restart a lockscreen app in case it crashes.";
    };

    session_lock_xray = mkNullOption {
        type = types.bool;
        description = "If `true`, keep rendering workspaces below your lockscreen.";
    };

    background_color = mkNullOption {
        type = localTypes.color;
        description = "Change the background color. (requires enabled `disable_hyprland_logo`)";
    };

    close_special_on_empty = mkNullOption {
        type = types.bool;
        description = "Close the special workspace if the last window is removed.";
    };

    on_focus_under_fullscreen = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            If there is a fullscreen or maximized window, decide whether a tiled window requested to focus should replace it, stay behind or disable the fullscreen/maximized state.
            - `0`: Ignore focus request (keep focus on fullscreen window).
            - `1`: Takes over.
            - `2`: Unfullscreen/unmaximize.
        '';
    };

    exit_window_retains_fullscreen = mkNullOption {
        type = types.bool;
        description = "If `true`, closing a fullscreen window makes the next focused window fullscreen.";
    };

    initial_workspace_tracking = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            If enabled, windows will open on the workspace they were invoked on.
            - `0`: Disabled.
            - `1`: Single-shot.
            - `2`: Persistent (all children too).
        '';
    };

    middle_click_paste = mkNullOption {
        type = types.bool;
        description = "Whether to enable middle-click-paste (aka primary selection).";
    };

    render_unfocused_fps = mkNullOption {
        type = types.ints.positive;
        description = "The maximum limit for render_unfocused windows' fps in the background (see also [Window-Rules](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#dynamic-effects) - `render_unfocused`).";
    };

    disable_xdg_env_checks = mkNullOption {
        type = types.bool;
        description = "Disable the warning if XDG environment is externally managed.";
    };

    disable_hyprland_qtutils_check = mkNullOption {
        type = types.bool;
        description = "Disable the warning if `hyprland-qtutils` is not installed.";
    };

    lockdead_screen_delay = mkNullOption {
        type = types.ints.positive;
        description = "Delay after which the \"lockdead\" screen will appear in case a lockscreen app fails to cover all the outputs (5 seconds max).";
    };

    enable_anr_dialog = mkNullOption {
        type = types.bool;
        description = "Whether to enable the ANR (app not responding) dialog when your apps hang.";
    };

    anr_missed_pings = mkNullOption {
        type = types.ints.positive;
        description = "Number of missed pings before showing the ANR dialog.";
    };

    size_limits_tiled = mkNullOption {
        type = types.bool;
        description = "Whether to apply `min_size` and `max_size` rules to tiled windows.";
    };

    disable_watchdog_warning = mkNullOption {
        type = types.bool;
        description = "Whether to disable the warning about not using `start-hyprland`.";
    };
}
