# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    mkArguments,
}:

{
    move_to_corner = mkArguments {
        named = [
            "corner"
            "window"
        ];
    };

    move = mkArguments {
        named = [
            "x"
            "y"
        ];
    };
}
