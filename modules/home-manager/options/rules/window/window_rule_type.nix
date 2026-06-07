# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    doubleElement,
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
    nonNullSubmodule,
}:

let
    inherit (lib) mkOption types;

    # === Enable ===
    enableOption = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to enable this `window_rule`.";
    };

    # === Match ===
    # Type
    matchType = nonNullSubmodule {
        options = import ./match_options.nix { inherit mkNullOption lib localTypes; };
    };
    # Option
    matchOption = mkOption {
        type = matchType;
        default = { };
        description = "What rules to apply when matching windows. Only windows that fulfill all conditions will have the effects applied on them. See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#props).";
    };

    # === Effects ===
    # Sub-types
    staticEffectsType = types.submodule {
        options = import ./static_effects.nix {
            inherit
                lib
                localTypes
                mkNullOption
                mkNullSubmodule
                nonNullSubmodule
                ;
        };
    };
    dynamicEffectsType = types.submodule {
        options = import ./dynamic_effects.nix {
            inherit
                doubleElement
                lib
                localTypes
                mkNullOption
                mkNullSubmodule
                ;
        };
    };
    # Sub-options
    staticEffectsOption = mkOption {
        type = staticEffectsType;
        default = { };
        description = "Static effects. See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#static-effects).";
    };
    dynamicEffectsOption = mkOption {
        type = dynamicEffectsType;
        default = { };
        description = "Dynamic effects. See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#dynamic-effects).";
    };
    # Type
    effectsType = types.submodule {
        options = {
            static = staticEffectsOption;
            dynamic = dynamicEffectsOption;
        };
    };
    # Option
    effectsOption = mkOption {
        type = effectsType;
        default = { };
        description = "Effects to apply to windows falling under this `window_rule`. See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#effects).";
    };
in
types.submodule {
    options = {
        enable = enableOption;
        match = matchOption;
        effects = effectsOption;
    };
}
