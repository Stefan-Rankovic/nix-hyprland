# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    doubleElement,
    forceNonNullIn,
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
    ...
}:

let
    inherit (lib) mkOption types;

    layerRuleType = import ./layer/layer_rule_type.nix {
        inherit
            forceNonNullIn
            lib
            localTypes
            mkNullOption
            ;
    };

    windowRuleType = import ./window/window_rule_type.nix {
        inherit
            doubleElement
            forceNonNullIn
            lib
            localTypes
            mkNullOption
            mkNullSubmodule
            ;
    };
in
{
    options.nix-hyprland.rules.unnamed = mkOption {
        type = types.submodule {
            options = {
                layer = mkOption {
                    type = types.listOf layerRuleType;
                    default = [ ];
                };
                window = mkOption {
                    type = types.listOf windowRuleType;
                    default = [ ];
                };
            };
        };
        default = { };
        description = "Unnamed rules.";
    };
}
