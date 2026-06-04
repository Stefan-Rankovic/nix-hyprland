# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
    ...
}:

let
    inherit (lib) types;
in
{
    snap = mkNullSubmodule {
        options = import ./snap.nix { inherit lib mkNullOption; };
    };

    border_size = mkNullOption {
        type = types.ints.unsigned;
        description = "Size of the border around windows.";
    };

    gaps_in = mkNullOption {
        type = localTypes.css_gaps;
        description = "Gaps between windows.";
    };

    gaps_out = mkNullOption {
        type = localTypes.css_gaps;
        description = "Gaps between windows and monitor edges.";
    };

    float_gaps = mkNullOption {
        type = types.either (types.enum [ "-1" ]) localTypes.css_gaps;
        # On the Hyprland wiki, this looks like:
        #   "gaps between windows and monitor edges for floating windows -1 means default"
        # I interpreted it as it's written in the `description` field, although it could also be interpreted as:
        #   "Gaps between windows and monitor edges. For floating windows, -1 means default."
        description = "Gaps between windows and monitor edges for floating windows. `-1` means default.";
    };

    gaps_workspaces = mkNullOption {
        type = localTypes.css_gaps;
        description = "Gaps between workspaces. Stacks with `gaps_out`.";
    };

    col = mkNullSubmodule {
        options = {
            inactive_border = mkNullOption {
                type = localTypes.gradient;
                description = "Border color for inactive windows.";
            };
            active_border = mkNullOption {
                type = localTypes.gradient;
                description = "Border color for the active window.";
            };
            nogroup_border = mkNullOption {
                type = localTypes.gradient;
                description = "Inactive border color for window that cannot be added to a group (see [hl.dsp.window.deny_from_group](https://wiki.hypr.land/Configuring/Basics/Dispatchers/#window-1) dispatcher).";
            };
            nogroup_border_active = mkNullOption {
                type = localTypes.gradient;
                description = "Active border color for window that cannot be added to a group.";
            };
        };
    };

    layout = mkNullOption {
        type = types.enum [
            "dwindle"
            "master"
            "scrolling"
            "monocle"
        ];
        description = "Which layout to use.";
    };

    no_focus_fallback = mkNullOption {
        type = types.bool;
        description = "If `true`, will not fall back to the next available window when moving focus in a direction where no window was found.";
    };

    resize_on_border = mkNullOption {
        type = types.bool;
        description = "Enables resizing windows by clicking and dragging on borders and gaps.";
    };

    extend_border_grab_area = mkNullOption {
        type = types.ints.unsigned;
        description = "Extends the area around the border where you can click and drag on, only used when `general.resize_on_border` is on.";
    };

    hover_icon_on_border = mkNullOption {
        type = types.bool;
        description = "Show a cursor icon when hovering over borders, only used when `general.resize_on_border` is on.";
    };

    allow_tearing = mkNullOption {
        type = types.bool;
        description = "Master switch for allowing tearing to occur. See [the tearing page](https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/).";
    };

    resize_corner = mkNullOption {
        type = types.either (types.ints.between 0 4) (
            types.enum [
                "top left"
                "top right"
                "bottom right"
                "bottom left"
                "disabled"
            ]
        );
        description = "Force floating windows to use a specific corner when being resized (1-4 going clockwise from top left, `0` to disable).";
    };

    modal_parent-blocking = mkNullOption {
        type = types.bool;
        description = "Whether parent windows of modals will be interactive.";
    };

    locale = mkNullOption {
        type = types.str;
        description = "Overrides the system locale (e.g. `\"en_US\"`, `\"es\"`).";
    };
}
