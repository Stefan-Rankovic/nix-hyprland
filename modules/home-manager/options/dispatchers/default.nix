# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
    oneNonNullSubmodule,
    ...
}:

let
    inherit (lib) mkOption types;
    dispatcherType = import ./dispatcher_type.nix {
        inherit
            lib
            localTypes
            mkNullOption
            mkNullSubmodule
            oneNonNullSubmodule
            ;
    };
in
{
    options.programs.nix-hyprland.dispatchers = mkOption {
        type = types.listOf dispatcherType;
        default = [ ];
        description = "Dispatcher calls to add to the resulting Lua file.";
    };
}
