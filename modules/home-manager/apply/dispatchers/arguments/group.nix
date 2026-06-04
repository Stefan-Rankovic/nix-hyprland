# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    mkArguments,
}:

{
    toggle = mkArguments { named = [ "window" ]; };

    next = mkArguments { named = [ "window" ]; };

    prev = mkArguments { named = [ "window" ]; };

    active = mkArguments {
        named = [
            "index"
            "window"
        ];
    };

    move_window = mkArguments {
        named = [
            "forward"
            "window"
        ];
    };

    lock = mkArguments {
        named = [
            "active"
            "window"
        ];
    };

    lock_active = mkArguments { named = [ "action" ]; };
}
