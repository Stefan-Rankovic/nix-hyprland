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
    enabled = mkNullOption {
        type = types.bool;
        description = "Enable snapping for floating windows.";
    };

    window_gap = mkNullOption {
        type = types.ints.unsigned;
        description = "Minimum gap in pixels between windows before snapping.";
    };

    monitor_gap = mkNullOption {
        type = types.ints.unsigned;
        description = "Minimum gap in pixels between window and monitor edges before snapping.";
    };

    border_overlap = mkNullOption {
        type = types.bool;
        description = "If true, windows snap such that only one border's worth of space is between them.";
    };

    respect_gaps = mkNullOption {
        type = types.bool;
        description = "If `true`, snapping will respect gaps between windows (set in `general:gaps_in`).";
    };
}
