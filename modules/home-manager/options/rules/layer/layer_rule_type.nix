# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    localTypes,
    mkNullOption,
    nonNullSubmodule,
}:

let
    inherit (lib) mkOption types;

    # === Enable ===
    enableOption = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to enable this `layer_rule`.";
    };

    # === Match ===
    # Type
    matchType = nonNullSubmodule {
        options = import ./match_options.nix { inherit localTypes mkNullOption; };
    };
    # Option
    matchOption = mkOption {
        type = matchType;
        default = { };
        description = "What rules to apply when matching layers. Only layers that fulfill all conditions will have the effects applied on them. See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#props-1).";
    };

    # === Effects ===
    # Type
    effectsType = types.submodule {
        options = import ./effects.nix { inherit lib mkNullOption; };
    };
    # Option
    effectsOption = mkOption {
        type = effectsType;
        default = { };
        description = "Effects to apply to layers falling under this `layer_rule`. See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#effects-1).";
    };
in
types.submodule {
    options = {
        enable = enableOption;
        match = matchOption;
        effects = effectsOption;
    };
}
