# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    exactlyOneNonNullSubmodule,
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
    ...
}:

let
    inherit (lib) mkOption types;
    dispatcherType = import ./dispatcher_type.nix {
        inherit
            exactlyOneNonNullSubmodule
            lib
            localTypes
            mkNullOption
            mkNullSubmodule
            ;
    };
in
{
    options.nix-hyprland.dispatchers = mkOption {
        type = types.listOf dispatcherType;
        default = [ ];
        description = "Dispatcher calls to add to the resulting Lua file.";
    };
}
