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
    inherit (lib) mkEnableOption mkOption types;

    # === Enable ===
    enableOption = mkEnableOption "this `bind`" // {
        default = true;
    };

    # === Main mod ===
    useMainModOption = mkNullOption {
        type = types.bool;
        description = "Whether to prefix this `bind`'s keys with `binds.mainMod`. Overrides `binds.mainMod.enable`. A value of `null` will use `binds.mainMod.enable`.";
    };

    # === Dispatcher ===
    # Type
    dspType = import ../dispatchers/dispatcher_type.nix {
        inherit
            exactlyOneNonNullSubmodule
            lib
            localTypes
            mkNullOption
            mkNullSubmodule
            ;
    };
    # Option
    dspOption = mkOption {
        type = dspType;
        description = "The dispatcher to use.";
    };

    # === Bind flags ===
    # Type
    flagsType = types.submodule {
        options = import ./flags.nix { inherit lib mkNullOption; };
    };
    # Option
    flagsOption = mkNullOption {
        type = flagsType;
        description = "Bind flags. See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Binds/#bind-flags).";
    };
in
types.submodule {
    options = {
        enable = enableOption;
        useMainMod = useMainModOption;
        dsp = dspOption;
        flags = flagsOption;
    };
}
