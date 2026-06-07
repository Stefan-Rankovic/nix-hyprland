# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    doubleElement,
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
    nonNullSubmodule,
    ...
}:

let
    inherit (lib) mkOption types;

    layerRuleType = import ./layer/layer_rule_type.nix {
        inherit
            lib
            localTypes
            mkNullOption
            nonNullSubmodule
            ;
    };

    windowRuleType = import ./window/window_rule_type.nix {
        inherit
            doubleElement
            lib
            localTypes
            mkNullOption
            mkNullSubmodule
            nonNullSubmodule
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
