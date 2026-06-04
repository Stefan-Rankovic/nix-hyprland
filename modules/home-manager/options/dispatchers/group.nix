# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    argPresets,
    lib,
    localTypes,
    mkDispatcher,
    mkNullOption,
    mkOption,
}:

let
    inherit (lib) types;
in
{
    toggle = mkDispatcher {
        options.window = mkNullOption { type = localTypes.window; };
        description = "Toggle a group.";
    };

    next = mkDispatcher {
        options.window = mkNullOption { type = localTypes.window; };
        description = "Switch to the next window in a group.";
    };

    prev = mkDispatcher {
        options.window = mkNullOption { type = localTypes.window; };
        description = "Switch to the previous window in a group.";
    };

    active = mkDispatcher {
        options = {
            index = mkOption {
                type = types.str; # todo: ?
                description = "I have no idea whether this is an integer, a string, or whatever. Please open an issue if you find out what this is.";
            };
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Switch to a window in a group, indexed.";
    };

    move_window = mkDispatcher {
        options = {
            forward = mkOption { type = types.bool; };
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Move a window in the group order.";
    };

    lock = mkDispatcher {
        options = {
            action = argPresets.optionalAction;
            window = mkNullOption { type = localTypes.window; };
        };
        description = "Lock a group.";
    };

    lock_active = mkDispatcher {
        options.action = argPresets.optionalAction;
        description = "Lock the active group.";
    };
}
