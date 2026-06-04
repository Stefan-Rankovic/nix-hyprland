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
    groupbar = mkNullSubmodule {
        options = import ./groupbar.nix {
            inherit
                lib
                localTypes
                mkNullOption
                mkNullSubmodule
                ;
        };
    };

    auto_group = mkNullOption {
        type = types.bool;
        description = "Whether new windows will be automatically grouped into the focused unlocked group. Note: if you want to disable `auto_group` only for specific windows, use [the \"group barred\" window rule](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#group-window-rule-options) instead.";
    };

    insert_after_current = mkNullOption {
        type = types.bool;
        description = "Whether new windows in a group spawn after current or at group tail.";
    };

    focus_removed_window = mkNullOption {
        type = types.bool;
        description = "Whether Hyprland should focus on the window that has just been moved out of the group.";
    };

    drag_into_group = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            Whether dragging a window into a unlocked group will merge them.
            - `0`: Disabled.
            - `1`: Enabled
            - `2`: Only when dragging into the groupbar.
        '';
    };

    merge_groups_on_drag = mkNullOption {
        type = types.bool;
        description = "Whether window groups can be dragged into other groups.";
    };

    merge_groups_on_groupbar = mkNullOption {
        type = types.bool;
        description = "Whether one group will be merged with another when dragged into its groupbar.";
    };

    merge_floated_into_tiled_on_groupbar = mkNullOption {
        type = types.bool;
        description = "Whether dragging a floating window into a tiled window groupbar will merge them.";
    };

    group_on_movetoworkspace = mkNullOption {
        type = types.bool;
        description = "Whether using movetoworkspace[silent] will merge the window into the workspace's solitary unlocked group.";
    };

    col = mkNullSubmodule {
        options = {
            border_active = mkNullOption {
                type = localTypes.gradient;
                description = "Active group border color.";
            };
            border_inactive = mkNullOption {
                type = localTypes.gradient;
                description = "Inactive (out of focus) group border color.";
            };
            border_locked_active = mkNullOption {
                type = localTypes.gradient;
                description = "Active locked group border color.";
            };
            border_locked_inactive = mkNullOption {
                type = localTypes.gradient;
                description = "Inactive locked group border color.";
            };
        };
    };
}
