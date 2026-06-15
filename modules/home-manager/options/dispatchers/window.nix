# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    argPresets,
    lib,
    localTypes,
    mkDispatcher,
    mkNullOption,
    mkNullSubmodule,
    xNonNullSubmodule,
}:

let
    inherit (lib) mkOption types;
in
{
    close = mkDispatcher {
        options.window = mkNullOption { type = localTypes.window; };
        description = "Send a graceful request to close the window.";
    };

    kill = mkDispatcher {
        options.window = mkNullOption { type = localTypes.window; };
        description = "Kill the process owning the window with a `SIGKILL`.";
    };

    signal = mkDispatcher {
        options = {
            signal = mkOption {
                type = types.str; # todo: custom type?
            };
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Send a POSIX signal to the process owning the window.";
    };

    float = mkDispatcher {
        options = {
            action = argPresets.optionalAction;
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Set a window’s floating state.";
    };

    fullscreen = mkDispatcher {
        options = {
            mode = mkNullOption {
                type = types.enum [
                    "maximized"
                    "fullscreen"
                ];
            };
            action = mkNullOption { type = localTypes.fullscreen_action; };
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Set a window's fullscreen state.";
    };

    fullscreen_state = mkDispatcher {
        options = {
            internal = mkOption { type = localTypes.fullscreen_state; };
            client = mkOption { type = localTypes.fullscreen_state; };
            action = mkNullOption { type = localTypes.fullscreen_action; };
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Set a window's fullscreen state with more precision. See [Fullscreenstate on the Hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Dispatchers/#fullscreenstate).";
    };

    pseudo = mkDispatcher {
        options = {
            action = argPresets.optionalAction;
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Set a window's pseudotiling state.";
    };

    move = mkNullOption {
        type = xNonNullSubmodule 1 {
            options = {
                direction = mkNullOption {
                    type = types.either localTypes.direction (
                        types.submodule {
                            options = {
                                direction = mkOption { type = localTypes.direction; };
                                group_aware = mkNullOption {
                                    type = types.bool;
                                    description = "A value of `true` will put the window in/out of groups alongside the given direction.";
                                };
                                window = mkNullOption { type = localTypes.window; };
                            };
                        }
                    );
                    description = "Move a window in a direction.";
                };
                workspace = mkNullOption {
                    type = types.either localTypes.workspace (
                        types.submodule {
                            options = {
                                workspace = mkOption { type = localTypes.workspace; };
                                follow = mkNullOption { type = types.bool; };
                                window = mkNullOption { type = localTypes.window; };
                            };
                        }
                    );
                    description = "Move a window to a workspace.";
                };
                monitor = mkNullOption {
                    type = types.either localTypes.monitor (
                        types.submodule {
                            options = {
                                monitor = mkOption { type = localTypes.monitor; };
                                follow = mkNullOption { type = types.bool; };
                                window = mkNullOption { type = localTypes.window; };
                            };
                        }
                    );
                    description = "Move a window to a monitor.";
                };
                coordinates = mkNullSubmodule {
                    options = {
                        x = mkOption { type = types.ints.unsigned; };
                        y = mkOption { type = types.ints.unsigned; };
                        relative = mkNullOption { type = types.bool; };
                        window = mkNullOption { type = localTypes.window; };
                    };
                    description = "Move the window by/to a coord.";
                };
                into_group = mkNullOption {
                    type = types.either localTypes.direction (
                        types.submodule {
                            options = {
                                direction = mkOption { type = localTypes.direction; };
                                window = mkNullOption { type = localTypes.window; };
                            };
                        }
                    );
                    description = "Move a window into a group in a direction.";
                };
                into_or_create_group = mkNullOption {
                    type = types.either localTypes.direction (
                        types.submodule {
                            options = {
                                direction = mkOption { type = localTypes.direction; };
                                window = mkNullOption { type = localTypes.window; };
                            };
                        }
                    );
                    description = "Move a window into a group in a direction, or create a group if no group exists in that direction.";
                };
                out_of_group = mkNullOption {
                    type = types.either localTypes.direction (
                        types.submodule {
                            options = {
                                direction = mkOption {
                                    type = types.either types.bool localTypes.direction;
                                    description = "`true` for directionless, `direction` for a direction.";
                                };
                                window = mkNullOption { type = localTypes.window; };
                            };
                        }
                    );
                    description = "Move a window out of a group.";
                };
            };
        };
        description = "Move a window.";
    };

    swap = mkNullOption {
        type = xNonNullSubmodule 1 {
            options = {
                direction = mkNullOption {
                    type = localTypes.direction;
                    description = "Swap the current window with another one in a given direction.";
                };
                target = mkNullOption {
                    type = localTypes.window;
                    description = "Swap the current window with another one.";
                };
                next = mkDispatcher {
                    options = { };
                    description = "Swap the current window with the next one.";
                };
                prev = mkDispatcher {
                    options = { };
                    description = "Swap the current window with the previous one.";
                };
            };
        };
        description = "Swap the current window.";
    };

    center = mkDispatcher {
        options.window = mkNullOption { type = localTypes.window; };
        description = "Center the current window on screen.";
    };

    cycle_next = mkDispatcher {
        options = {
            # todo: are these booleans or...?
            next = mkNullOption { type = localTypes.unit; };
            tiled = mkNullOption { type = localTypes.unit; };
            floating = mkNullOption { type = localTypes.unit; };
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Focus the next window.";
    };

    tag = mkDispatcher {
        options = {
            tag = mkOption { type = types.str; };
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Tag a window.";
    };

    clear_tags = mkDispatcher {
        options.window = mkNullOption { type = localTypes.window; };
        description = "Clear all tags from a window.";
    };

    toggle_swallow = mkDispatcher {
        options = { };
        description = "Toggle all swallowed windows visible.";
    };

    pin = mkDispatcher {
        options.window = mkNullOption { type = localTypes.window; };
        description = "Pin a window.";
    };

    alter_zorder = mkDispatcher {
        options = {
            mode = mkOption {
                type = types.enum [
                    "top"
                    "bottom"
                ];
            };
            window = mkNullOption { type = localTypes.window; };
        };
    };

    set_prop = mkDispatcher {
        options = {
            prop = mkOption {
                type = types.str;
                description = "I am not sure what type this is. If you find out, please open an issue. Until then, this is a todo.";
            };
            value = mkOption { type = types.anything; };
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Set a window propery.";
    };

    deny_from_group = mkDispatcher {
        options.action = argPresets.optionalAction;
        description = "Deny a window from entering a group.";
    };

    resize = mkDispatcher {
        options = {
            x = mkOption { type = types.ints.unsigned; };
            y = mkOption { type = types.ints.unsigned; };
            relative = mkNullOption { type = types.bool; };
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Resize a window.";
    };
}
