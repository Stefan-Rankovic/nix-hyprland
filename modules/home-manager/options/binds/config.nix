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
    pass_mouse_when_bound = mkNullOption {
        type = types.bool;
        description = "If disabled, will not pass mouse events to apps or drag windows if a keybind has been triggered.";
    };

    scroll_event_delay = mkNullOption {
        type = types.ints.unsigned;
        description = "In ms, how long to wait after a scroll event before allowing another one for the binds.";
    };

    workspace_back_and_forth = mkNullOption {
        type = types.bool;
        description = "If enabled, an attempt to switch to the currently focused workspace will instead switch to the previous workspace. Akin to i3's `auto_back_and_forth`.";
    };

    hide_special_on_workspace_change = mkNullOption {
        type = types.bool;
        description = "If enabled, changing the active workspace (including to itself) will hide the special workspace on the monitor where the newly active workspace resides.";
    };

    allow_workspace_cycles = mkNullOption {
        type = types.bool;
        description = "If enabled, workspaces don't forget their previous workspace, so cycles can be created by switching to the first workspace in a sequence, then endlessly going to the previous workspace.";
    };

    workspace_center_on = mkNullOption {
        type = types.ints.between 0 1;
        description = ''
            Whether switching workspaces should center the cursor on:
            - `0`: The workspace.
            - `1`: The last active window for that workspace.
        '';
    };

    focus_preferred_method = mkNullOption {
        type = types.ints.between 0 1;
        description = ''
            Sets the preferred focus finding method when using `hl.dsp.focus({ direction })` and similar.
            - `0`: History (most recently focused have priority).
            - `1`: Length (longer shared edges have priority).
        '';
    };

    ignore_group_lock = mkNullOption {
        type = types.bool;
        description = "If enabled, dispatchers like `hl.dsp.window.move({ into_group })` and `hl.dsp.window.move({ out_of_group })` will ignore lock per group.";
    };

    movefocus_cycles_fullscreen = mkNullOption {
        type = types.bool;
        description = "If enabled, when on a fullscreen window, `hl.dsp.focus({ direction })` will cycle fullscreen, rather than moving focus in a direction.";
    };

    movefocus_cycles_groupfirst = mkNullOption {
        type = types.bool;
        description = "If enabled, when in a grouped window, `hl.dsp.focus({ direction })` will cycle windows in the group first, then move on to other windows/groups at each end.";
    };

    window_direction_monitor_fallback = mkNullOption {
        type = types.bool;
        description = "If enabled, moving a window or focus over the edge of a monitor with a direction will move it to the next monitor in that direction.";
    };

    disable_keybind_grabbing = mkNullOption {
        type = types.bool;
        description = "If enabled, apps that request keybinds to be disabled (e.g. VMs) will not be able to do so.";
    };

    allow_pin_fullscreen = mkNullOption {
        type = types.bool;
        description = "If enabled, allow fullscreen to pinned windows and restore their pinned status afterwards.";
    };

    drag_threshold = mkNullOption {
        type = types.ints.unsigned;
        description = "Movement threshold in pixels for window dragging and `c`/`g` bind flags. `0` disables the threshold and grabs on mousedown.";
    };
}
