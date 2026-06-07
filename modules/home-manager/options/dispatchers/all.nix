# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    exactlyOneNonNullSubmodule,
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
}:

let
    inherit (lib) mkOption types;

    mkDispatcher =
        {
            description ? "",
            options,
        }:
        mkNullOption {
            inherit description;
            type = lib.types.submodule {
                inherit options;
            };
        };

    argPresets = {
        requiredCmd = mkOption {
            type = types.str;
            description = "The command to execute";
        };

        optionalAction = mkNullOption {
            type = types.enum [
                "toggle"
                "enable"
                "on"
                "disable"
                "off"
            ];
        };
    };
in
{
    raw_lua = mkDispatcher {
        options.code = mkOption {
            type = types.str;
            description = "The exact lua code to insert.";
        };
        description = "For if you don't want to use one of Hyprland's dispatchers directly, but want to make a lua function wrapper.";
    };

    cursor = mkNullOption {
        type = exactlyOneNonNullSubmodule {
            options = import ./cursor.nix {
                inherit
                    lib
                    localTypes
                    mkDispatcher
                    mkNullOption
                    ;
            };
        };
    };

    group = mkNullOption {
        type = exactlyOneNonNullSubmodule {
            options = import ./group.nix {
                inherit
                    argPresets
                    lib
                    localTypes
                    mkDispatcher
                    mkNullOption
                    mkOption
                    ;
            };
        };
    };

    window = mkNullOption {
        type = exactlyOneNonNullSubmodule {
            options = import ./window.nix {
                inherit
                    argPresets
                    exactlyOneNonNullSubmodule
                    lib
                    localTypes
                    mkDispatcher
                    mkNullOption
                    mkNullSubmodule
                    ;
            };
        };
    };

    workspace = mkNullOption {
        type = exactlyOneNonNullSubmodule {
            options = import ./workspace.nix {
                inherit
                    lib
                    localTypes
                    mkDispatcher
                    mkNullOption
                    ;
            };
        };
    };

    exec_cmd = mkDispatcher {
        options = {
            cmd = argPresets.requiredCmd;
            rules = mkNullOption {
                type = types.attrs;
                description = "See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Dispatchers/#executing-with-rules).";
            };
        };
        description = "Execute a command.";
    };

    exec_raw = mkDispatcher {
        options.cmd = argPresets.requiredCmd;
        description = "Execute a raw command. While `exec_cmd` will do `sh -c`, this won’t.";
    };

    focus = mkNullOption {
        type = exactlyOneNonNullSubmodule {
            options = {
                direction = mkNullOption {
                    type = localTypes.direction;
                    description = "Move the focus in a direction.";
                };
                monitor = mkNullOption {
                    type = localTypes.monitor;
                    description = "Move the focus to a monitor.";
                };
                workspace = mkNullOption {
                    type = types.either localTypes.workspace (
                        types.submodule {
                            options = {
                                workspace = mkOption {
                                    type = localTypes.workspace;
                                    description = "Workspace to move to.";
                                };
                                on_current_monitor = mkNullOption { type = types.bool; };
                            };
                        }
                    );
                };
                window = mkNullOption {
                    type = localTypes.window;
                    description = "Move the focus to a window.";
                };
                urgent_or_last = mkNullOption {
                    type = localTypes.unit;
                    description = "Move the focus to an urgent, or last window.";
                };
                last = mkNullOption {
                    type = localTypes.unit;
                    description = "Move the focus to the last window.";
                };
            };
        };
        description = "Move the focus.";
    };

    exit = mkNullOption {
        type = localTypes.unit;
        description = ''
            Quit Hyprland. It’s recommended to use `hyprshutdown` instead of this.

            [uwsm](https://wiki.hypr.land/Useful-Utilities/Systemd-start) users should avoid using exit dispatcher, or terminating Hyprland process directly, as exiting Hyprland this way removes it from under its clients and interferes with ordered shutdown sequence.
            Use `hl.dsp.exec_cmd("uwsm stop")` (or [other variants](https://github.com/Vladimir-csp/uwsm#how-to-stop)) which will gracefully bring down graphical session (and login session bound to it, if any).
            If you experience problems with units entering inconsistent states, affecting subsequent sessions, use `hl.dsp.exec_cmd("loginctl terminate-user \"\"")` instead (terminates all units of the user).
            If you are not sure whether you use UWSM and thus do not know if this warning applies to you, you're probably using UWSM (this configuration enables it by default).
        '';
    };

    submap = mkDispatcher {
        options.name = mkOption { type = types.str; };
        description = "Move to a submap.";
    };

    pass = mkDispatcher {
        options.window = mkNullOption { type = localTypes.window; };
        description = "Pass the shortcut to a window.";
    };

    send_shortcut = mkDispatcher {
        options = {
            mods = mkOption {
                type = types.str;
            };
            key = mkOption {
                type = types.str;
            };
            window = mkNullOption { type = localTypes.window; };
        };

        description = "Send a specific shortcut to a window.";
    };

    send_key_state = mkDispatcher {
        options = {
            mods = mkOption {
                type = types.str;
            };
            key = mkOption {
                type = types.str;
            };
            state = mkOption {
                type = types.enum [
                    "down"
                    "up"
                ];
            };
            window = mkNullOption { type = localTypes.window; };
        };

        description = "Same as `send_shortcut` but you control `down`/`up`.";
    };

    layout = mkDispatcher {
        options.message = mkOption { type = types.str; };
        description = "Send a layout message as a string.";
    };

    dpms = mkDispatcher {
        options = {
            action = argPresets.optionalAction;
            monitor = mkNullOption { type = localTypes.monitor; };
        };
        description = ''
            Toggle monitors on/off (not physically, but as in idle-screensaver).

            It is not recommended to set DPMS or forceidle with a keybind directly, as it might cause undefined behavior. Instead, consider something like:
            ```nix
            nix-hyprland.binds."...".dsp.raw_lua = '''
                function()
                    hl.timer(function()
                        hl.dispatch(hl.dsp.dpms({ action = "disable" }))
                    end, {timeout = 500, type = "oneshot"})
                end
            ''';
            ```
        '';
    };

    event = mkDispatcher {
        options.string = mkOption { type = types.str; };
        description = "Send an event to `socket2`.";
    };

    global = mkDispatcher {
        options.string = mkOption { type = types.str; };
        description = "Activate a dbus global shortcut. See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Binds#dbus-global-shortcuts).";
    };

    force_idle = mkDispatcher {
        options.seconds = mkOption { type = types.numbers.nonnegative; };
        description = "sets elapsed time for all idle timers, ignoring idle inhibitors. Timers return to normal behavior upon the next activity. **Do not use with a keybind directly (see `dpms` description).**";
    };

    no_op = mkNullOption {
        type = localTypes.unit;
        description = "Does nothing. Useful for conditional binds.";
    };
}
