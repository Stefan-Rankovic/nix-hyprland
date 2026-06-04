# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    localTypes,
    mkDispatcher,
    mkNullOption,
}:

let
    inherit (lib) mkOption types;
in
{
    move_to_corner = mkDispatcher {
        options = {
            corner = mkOption { type = types.ints.between 0 3; };
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Move the cursor to a given corner of the window.";
    };

    move = mkDispatcher {
        options = {
            x = mkOption { type = types.ints.unsigned; };
            y = mkOption { type = types.ints.unsigned; };
        };
        description = "Move the cursor to a given coordinate.";
    };
}
