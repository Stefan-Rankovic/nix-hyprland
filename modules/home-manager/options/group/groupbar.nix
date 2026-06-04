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
    enabled = mkNullOption {
        type = types.bool;
        description = "Enables groupbars.";
    };

    font_family = mkNullOption {
        type = types.str;
        description = "Font used to display groupbar titles, use `misc.font_family` if not specified.";
    };

    font_size = mkNullOption {
        type = types.ints.positive;
        description = "Font size of groupbar title.";
    };

    font_weight_active = mkNullOption {
        type = localTypes.font_weight;
        description = "Font weight of active groupbar title.";
    };

    font_weight_inactive = mkNullOption {
        type = localTypes.font_weight;
        description = "Font weight of inactive groupbar title.";
    };

    gradients = mkNullOption {
        type = types.bool;
        description = "Enables gradients.";
    };

    height = mkNullOption {
        type = types.ints.positive;
        description = "Height of the groupbar.";
    };

    indicator_gap = mkNullOption {
        type = types.ints.unsigned;
        description = "Height of gap between groupbar indicator and title.";
    };

    indicator_height = mkNullOption {
        type = types.ints.unsigned;
        description = "Height of the groupbar indicator.";
    };

    stacked = mkNullOption {
        type = types.bool;
        description = "Render the groupbar as a vertical stack.";
    };

    priority = mkNullOption {
        type = types.ints.unsigned;
        description = "Sets the decoration priority for groupbars.";
    };

    render_titles = mkNullOption {
        type = types.bool;
        description = "Whether to render titles in the group bar decoration.";
    };

    text_offset = mkNullOption {
        type = types.int;
        description = "Adjust vertical position for titles.";
    };

    text_padding = mkNullOption {
        type = types.ints.unsigned;
        description = "Set horizontal padding for titles.";
    };

    scrolling = mkNullOption {
        type = types.bool;
        description = "Whether scrolling in the groupbar changes group active window.";
    };

    rounding = mkNullOption {
        type = types.ints.unsigned;
        description = "How much to round the indicator.";
    };

    rounding_power = mkNullOption {
        type = types.numbers.between 1.0 10.0;
        description = "Adjusts the curve used for rounding groupbar corners, larger is smoother, `2.0` is a circle, `4.0` is a squircle, `1.0` is a triangular corner.";
    };

    gradient_rounding = mkNullOption {
        type = types.ints.unsigned;
        description = "How much to round the gradients.";
    };

    gradient_rounding_power = mkNullOption {
        type = types.numbers.between 1.0 10.0;
        description = "Adjusts the curve used for rounding gradient corners, larger is smoother, `2.0` is a circle, `4.0` is a squircle, `1.0` is a triangular corner.";
    };

    round_only_edges = mkNullOption {
        type = types.bool;
        description = "Round only the indicator edges of the entire groupbar.";
    };

    gradient_round_only_edges = mkNullOption {
        type = types.bool;
        description = "Round only the gradient edges of the entire groupbar.";
    };

    text_color = mkNullOption {
        type = localTypes.color;
        description = "Color for window titles in the groupbar.";
    };

    text_color_inactive = mkNullOption {
        type = localTypes.color;
        description = "Color for inactive windows' titles in the groupbar (if unset, defaults to `text_color`).";
    };

    text_color_locked_active = mkNullOption {
        type = localTypes.color;
        description = "Color for the active window's title in a locked group (if unset, defaults to `text_color`).";
    };

    text_color_locked_inactive = mkNullOption {
        type = localTypes.color;
        description = "Color for inactive windows' titles in locked groups (if unset, defaults to `text_color_inactive`).";
    };

    col = mkNullSubmodule {
        options = {
            active = mkNullOption {
                type = localTypes.gradient;
                description = "Active group bar background color.";
            };
            inactive = mkNullOption {
                type = localTypes.gradient;
                description = "Inactive (out of focus) group bar background color.";
            };
            locked_active = mkNullOption {
                type = localTypes.gradient;
                description = "Active locked group bar background color.";
            };
            locked_inactive = mkNullOption {
                type = localTypes.gradient;
                description = "Inactive locked group bar background color.";
            };
        };
    };

    gaps_in = mkNullOption {
        type = types.ints.unsigned;
        description = "Gap size between gradients.";
    };

    gaps_out = mkNullOption {
        type = types.ints.unsigned;
        description = "Gap size between gradients and window.";
    };

    keep_upper_gap = mkNullOption {
        type = types.bool;
        description = "Add or remove upper gap.";
    };

    middle_click_close = mkNullOption {
        type = types.bool;
        description = "Whether middle clicking the groupbar closes the clicked window.";
    };

    blur = mkNullOption {
        type = types.bool;
        description = "Applies blur to the groupbar indicators and gradients.";
    };
}
