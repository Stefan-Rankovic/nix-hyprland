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
    invisible = mkNullOption {
        type = types.bool;
        description = "Don't render cursors.";
    };

    sync_gsettings_theme = mkNullOption {
        type = types.bool;
        description = "Sync the XCursor theme with gsettings, applying `cursor-theme` and `cursor-size` on theme load so that most CSD GTK clients use the same cursor theme and size.";
    };

    no_hardware_cursors = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            Disables hardware cursors.
            - `0`: Use hardware cursors if possible.
            - `1`: Never use hardware cursors.
            - `2`: Auto (disable when tearing).
        '';
    };

    no_break_fs_vrr = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            Disables scheduling new frames on cursor movement for fullscreen apps with VRR enabled, to avoid framerate spikes. May require `no_hardware_cursors = 1`.
            - `0`: Off.
            - `1`: On.
            - `2`: Auto (on with content type `game`).
        '';
    };

    min_refresh_rate = mkNullOption {
        type = types.ints.positive;
        description = "Minimum refresh rate for cursor movement when `no_break_fs_vrr` is active. Set to the minimum supported refresh rate or higher.";
    };

    hotspot_padding = mkNullOption {
        type = types.ints.unsigned;
        description = "The padding in logical px between screen edges and the cursor.";
    };

    inactive_timeout = mkNullOption {
        type = types.numbers.nonnegative;
        description = "In seconds, after how many seconds of cursor inactivity to hide it. Set to `0` to never hide.";
    };

    no_warps = mkNullOption {
        type = types.bool;
        description = "If `true`, will not warp the cursor in many cases (focusing, keybinds, etc.).";
    };

    persistent_warps = mkNullOption {
        type = types.bool;
        description = "When a window is refocused, the cursor returns to its last position relative to that window rather than to the center.";
    };

    warp_on_change_workspace = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            Move the cursor to the last focused window after changing the workspace.
            - `0`: Disabled.
            - `1`: Enabled.
            - `2`: Force (ignores `cursor.no_warps`).
        '';
    };

    warp_on_toggle_special = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            Move the cursor to the last focused window when toggling a special workspace.
            - `0`: Disabled.
            - `1`: Enabled.
            - `2`: Force (ignores `cursor.no_warps`).
        '';
    };

    default_monitor = mkNullOption {
        type = types.str;
        description = "The name of the default monitor for the cursor to be placed on at startup. See `hyprctl monitors` for names.";
    };

    zoom_factor = mkNullOption {
        type = types.float // {
            check = v: types.float.check v && v >= 1.0;
            name = "float (minimum 1.0)";
        };
        description = "The factor to zoom by around the cursor, like a magnifying glass. Minimum `1.0` (no zoom).";
    };

    zoom_rigid = mkNullOption {
        type = types.bool;
        description = "Whether the zoom should follow the cursor rigidly (cursor always centered if possible) or loosely.";
    };

    zoom_detached_camera = mkNullOption {
        type = types.bool;
        description = "Detach the camera from the mouse when zoomed in, only moving the camera to keep the mouse in view when it reaches screen edges.";
    };

    enable_hyprcursor = mkNullOption {
        type = types.bool;
        description = "Whether to enable Hyprcursor support.";
    };

    hide_on_key_press = mkNullOption {
        type = types.bool;
        description = "Hides the cursor when any key is pressed, until the mouse is moved again.";
    };

    hide_on_touch = mkNullOption {
        type = types.bool;
        description = "Hides the cursor when the last input was a touch input, until a mouse input is made.";
    };

    hide_on_tablet = mkNullOption {
        type = types.bool;
        description = "Hides the cursor when the last input was a tablet input, until a mouse input is made.";
    };

    use_cpu_buffer = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            Makes hardware cursors use a CPU buffer. Required on Nvidia to have hardware cursors.
            - `0`: Off.
            - `1`: On.
            - `2`: Auto (Nvidia only).
        '';
    };

    warp_back_after_non_mouse_input = mkNullOption {
        type = types.bool;
        description = "Warp the cursor back to where it was after using a non-mouse input to move it, once mouse input resumes.";
    };

    zoom_disable_aa = mkNullOption {
        type = types.bool;
        description = "Disable antialiasing when zooming, producing pixelated rather than blurry results.";
    };
}
