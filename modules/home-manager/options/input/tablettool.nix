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
    eraser_button_mode = mkNullOption {
        type = types.ints.between 0 1;
        description = ''
            Change the eraser button behavior on the tool.
            - `0`: Use the default hardware behavior of the tool.
            - `1`: The eraser button on the tool sends a button event instead.'';
    };

    eraser_button_override = mkNullOption {
        type = types.ints.unsigned;
        description = "Set a button to be button event when `eraser_button_mode` is set to `1`. Must be a valid button (e.g. BTN_STYLUS) excluding fake buttons (e.g. BTN_TOOL_) and keys (KEY_). Check `wev` if you have any doubts regarding the ID. `0` means default.";
    };

    pressure_range_min = mkNullOption {
        type = types.float;
        description = "Set the minimum pressure range for the tool, a negative number will set the default minimum pressure value. This is usually `0.0`.";
    };

    pressure_range_max = mkNullOption {
        type = types.float;
        description = "Set the maximum pressure range for the tool, a negative number will set the default maximum pressure value. This is usually `1.0`.";
    };
}
