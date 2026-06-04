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
    workspace_swipe_distance = mkNullOption {
        type = types.ints.positive;
        description = "In px, the distance of the touchpad gesture.";
    };

    workspace_swipe_touch = mkNullOption {
        type = types.bool;
        description = "Enable workspace swiping from the edge of a touchscreen.";
    };

    workspace_swipe_invert = mkNullOption {
        type = types.bool;
        description = "Invert the direction (touchpad only).";
    };

    workspace_swipe_touch_invert = mkNullOption {
        type = types.bool;
        description = "Invert the direction (touchscreen only).";
    };

    workspace_swipe_min_speed_to_force = mkNullOption {
        type = types.ints.unsigned;
        description = "Minimum speed in px per timepoint to force the change ignoring `cancel_ratio`. Setting to `0` will disable this mechanic.";
    };

    workspace_swipe_cancel_ratio = mkNullOption {
        type = types.numbers.between 0.0 1.0;
        description = "How much the swipe has to proceed in order to commence it. (0.7 -> if > 0.7 * distance, switch, if less, revert).";
    };

    workspace_swipe_create_new = mkNullOption {
        type = types.bool;
        description = "Whether a swipe right on the last workspace should create a new one.";
    };

    workspace_swipe_direction_lock = mkNullOption {
        type = types.bool;
        description = "If enabled, switching direction will be locked when you swipe past the `direction_lock_threshold` (touchpad only).";
    };

    workspace_swipe_direction_lock_threshold = mkNullOption {
        type = types.ints.unsigned;
        description = "In px, the distance to swipe before direction lock activates (touchpad only).";
    };

    workspace_swipe_forever = mkNullOption {
        type = types.bool;
        description = "If enabled, swiping will not clamp at the neighboring workspaces but continue to the further ones.";
    };

    workspace_swipe_use_r = mkNullOption {
        type = types.bool;
        description = "If enabled, swiping will use the `r` prefix instead of the `m` prefix for finding workspaces.";
    };

    close_max_timeout = mkNullOption {
        type = types.ints.positive;
        description = "The timeout for a window to close when using a 1:1 gesture, in ms.";
    };
}
