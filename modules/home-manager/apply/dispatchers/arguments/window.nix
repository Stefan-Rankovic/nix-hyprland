# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    mkArguments,
}:

{
    close = mkArguments { unnamed = [ "window" ]; };

    kill = mkArguments { unnamed = [ "window" ]; };

    signal = mkArguments {
        named = [
            "signal"
            "window"
        ];
    };

    float = mkArguments {
        named = [
            "action"
            "window"
        ];
    };

    fullscreen = mkArguments {
        named = [
            "mode"
            "action"
            "window"
        ];
    };

    fullscreen_state = mkArguments {
        named = [
            "internal"
            "client"
            "action"
            "window"
        ];
    };

    pseudo = mkArguments {
        named = [
            "action"
            "window"
        ];
    };

    move = mkArguments {
        getFromOrAreNamed = [
            "direction"
            "workspace"
            "monitor"
        ];
        getNamedFrom = [
            "coordinates"
            "into_group"
            "into_or_create_group"
            "out_of_group"
        ];
    };

    swap = mkArguments {
        named = [
            "direction"
            "target"
            "next"
            "prev"
        ];
    };

    center = mkArguments { named = [ "window" ]; };

    cycle_next = mkArguments {
        named = [
            "next"
            "tiled"
            "floating"
            "window"
        ];
    };

    tag = mkArguments {
        named = [
            "tag"
            "window"
        ];
    };

    clear_tags = mkArguments { named = [ "window" ]; };

    toggle_swallow = mkArguments { };

    pin = mkArguments { named = [ "window" ]; };

    alter_zorder = mkArguments {
        named = [
            "mode"
            "window"
        ];
    };

    set_prop = mkArguments {
        named = [
            "prop"
            "value"
            "window"
        ];
    };

    deny_from_group = mkArguments { named = [ "action" ]; };

    resize = mkArguments {
        named = [
            "x"
            "y"
            "relative"
            "windo"
        ];
    };
}
