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
    monitor = mkNullOption {
        type = localTypes.monitor;
        description = "Binds a workspace to a monitor. See [syntax](https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/#syntax) and [Monitors](https://wiki.hypr.land/Configuring/Basics/Monitors).";
    };

    default = mkNullOption {
        type = types.bool;
        description = "Whether this workspace should be the default workspace for the given monitor.";
    };

    gaps_in = mkNullOption {
        type = localTypes.css_gaps;
        description = "Set the gaps between windows (equivalent to [General->gaps_in](https://wiki.hypr.land/Configuring/Basics/Variables#general)).";
    };

    gaps_out = mkNullOption {
        type = localTypes.css_gaps;
        description = "Set the gaps between windows and monitor edges (equivalent to [General->gaps_out](https://wiki.hypr.land/Configuring/Basics/Variables#general)).";
    };

    border_size = mkNullOption {
        type = localTypes.ints.unsigned;
        description = "Set the border size around windows (equivalent to [General->gaps_out](https://wiki.hypr.land/Configuring/Basics/Variables#general)).";
    };

    no_border = mkNullOption {
        type = types.bool;
        description = "Whether to disable borders.";
    };

    no_shadow = mkNullOption {
        type = types.bool;
        description = "Whether to disable shadows.";
    };

    no_rounding = mkNullOption {
        type = types.bool;
        description = "Whether to disable rounded windows.";
    };

    decorate = mkNullOption {
        type = types.bool;
        description = "Whether to draw window decorations or not.";
    };

    persistent = mkNullOption {
        type = types.bool;
        description = "Keep this workspace alive even if empty and inactive.";
    };

    on_created_empty = mkNullOption {
        type = types.str;
        description = "A command to be executed once a workspace is created empty (i.e. not created by moving a window to it). See the [comamnd syntax](https://wiki.hypr.land/Configuring/Basics/Dispatchers#executing-with-rules).";
    };

    default_name = mkNullOption {
        type = types.str;
        description = "A default name for the workspace.";
    };

    layout = mkNullOption {
        type = localTypes.layout;
        description = "The layout to use for this workspace.";
    };

    animation = mkNullOption {
        type = types.str; # todo: custom type?
        description = "The animation style to use for this workspace.";
    };
}
