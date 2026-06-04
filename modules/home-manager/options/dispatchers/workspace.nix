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
    rename = mkDispatcher {
        options = {
            workspace = mkOption { type = localTypes.workspace; };
            name = mkNullOption { type = types.str; };
        };
        description = "Rename a workspace.";
    };

    move = mkDispatcher {
        options = {
            workspace = mkNullOption { type = localTypes.workspace; };
            monitor = mkNullOption { type = localTypes.monitor; };
        };
        description = "Move a workspace to a monitor.";
    };

    swap_monitors = mkDispatcher {
        options = {
            monitor1 = mkOption { type = localTypes.monitor; };
            monitor2 = mkOption { type = localTypes.monitor; };
        };
        description = "Swap current workspaces of two monitors.";
    };

    toggle_special = mkDispatcher {
        options = {
            special_name = mkOption { type = types.str; };
        };
        description = "Toggle a special workspace by name.";
    };
}
