# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    mkArguments,
}:

{
    rename = mkArguments {
        named = [
            "workspace"
            "window"
        ];
    };

    move = mkArguments {
        named = [
            "workspace"
            "monitor"
        ];
    };

    swap_monitors = mkArguments {
        named = [
            "monitor1"
            "monitor2"
        ];
    };

    toggle_special = mkArguments { unnamed = [ "special_name" ]; };
}
