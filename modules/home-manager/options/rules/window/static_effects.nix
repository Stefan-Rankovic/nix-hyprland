# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
    nonNullSubmodule,
}:

let
    inherit (lib) mkOption types;

    strWithoutSuffixType =
        suffix:
        types.str
        // {
            typeMerge = _: null;
            check = v: types.str.check v && !(lib.hasSuffix suffix v);
        };

    falseOption = mkOption {
        type = types.bool;
        default = false;
    };
in
{
    float = mkNullOption {
        type = types.bool;
        description = "Floats a window.";
    };

    tile = mkNullOption {
        type = types.bool;
        description = "Tiles a window.";
    };

    fullscreen = mkNullOption {
        type = types.bool;
        description = "Fullscreens a window.";
    };

    maximize = mkNullOption {
        type = types.bool;
        description = "Maximizes a window.";
    };

    fullscreen_state = mkNullOption {
        type = types.str;
        description = ''
            Sets the fullscreen mode, e.g. `\"1 2\" (internal client).
            - `0`: None.
            - `1`: Maximize.
            - `2`: Fullscreen.
            - `3`: Maximize and fullscreen.
        '';
    };

    move = mkNullOption {
        type = types.str;
        description = "Moves a floating window to a given coordinate, monitor-local. E.g. `{100, 200}` or `{\"cursor_x-(window_w*0.5))\", \"(cursor_y-(window_h*0.5))\"}`.";
    };

    size = mkNullOption {
        type = types.str;
        description = "Resizes a floating window. E.g. `{800, 600}` or `{\"(monitor_w*0.5)\", \"(monitor_h*0.5)\"}`.";
    };

    center = mkNullOption {
        type = types.bool;
        description = "If the window is floating, will center it on the monitor.";
    };

    pseudo = mkNullOption {
        type = types.bool;
        description = "Pseudotiles a window.";
    };

    monitor = mkNullOption {
        type = types.either (strWithoutSuffixType " silent") (
            types.submodule {
                options = {
                    monitor = mkOption { type = types.str; };
                    silent = falseOption;
                };
            }
        );
        description = "Sets the monitor on which a window should open. E.g. `\"1\"` or `\"DP-1\"`.";
    };

    workspace = mkNullOption {
        type = types.either (strWithoutSuffixType " silent") (
            types.submodule {
                options = {
                    workspace = mkOption { type = types.str; };
                    silent = falseOption;
                };
            }
        );
        description = "Sets the workspace on which a window should open. Can also be \"unset\".";
    };

    no_initial_focus = mkNullOption {
        type = types.bool;
        description = "Disables the initial focus to the window.";
    };

    pin = mkNullOption {
        type = types.bool;
        description = "Pins the window (i.e. show it on all workspaces). *Note: floating only.*";
    };

    group = mkNullSubmodule {
        options = {
            set = mkNullSubmodule {
                options = {
                    use = mkOption { type = localTypes.unit; };
                    always = mkNullOption { type = localTypes.unit; };
                };
                description = "Open window as a group.";
            };
            new = mkNullOption {
                type = localTypes.unit;
                description = "Shorthand for `\"barred set\"`.";
            };
            lock = mkNullSubmodule {
                options = {
                    use = mkOption { type = localTypes.unit; };
                    always = mkNullOption { type = localTypes.unit; };
                };
                description = "Lock the group. Combine with `\"set\"` or `\"new\"`.";
            };
            barred = mkNullOption {
                type = localTypes.unit;
                description = "Do not automatically group into the focused unlocked group.";
            };
            deny = mkNullOption {
                type = localTypes.unit;
                description = "Do not allow the window to be toggled as or added to a group.";
            };
            invade = mkNullOption {
                type = localTypes.unit;
                description = "Force open window in the locked group.";
            };
            override = mkNullOption {
                type = types.str;
                description = ''
                    Override other `group` rules.

                    I'm not sure what exactly the type is so I just set it to `lib.types.str`; do whatever you want.
                '';
            };
            unset = mkNullOption {
                type = localTypes.unit;
                description = "Clear all `group` rules.";
            };
        };
        description = "Set window group properties. See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#group-window-rule-options).";
    };

    suppress_event = mkNullOption {
        type = nonNullSubmodule {
            options = {
                fullscreen = falseOption;
                maximize = falseOption;
                activate = falseOption;
                activatefocus = falseOption;
                fullscreenoutput = falseOption;
            };
        };
        description = "Floats a window.";
    };

    content = mkNullOption {
        type = localTypes.content_type;
        description = "Sets content type.";
    };

    no_close_for = mkNullOption {
        type = types.ints.positive;
        description = "Makes the window uncloseable with `killactive` for a given number of ms on open.";
    };

    scrolling_width = mkNullOption {
        type = types.ints.positive;
        description = "Set column width for window when starting on a workspace with the scrolling layout.";
    };
}
