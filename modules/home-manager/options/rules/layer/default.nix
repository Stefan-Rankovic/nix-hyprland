# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    localTypes,
    mkNullOption,
    nonNullSubmodule,
    ...
}:

let
    inherit (lib) mkOption types;

    layerRuleType = import ./layer_rule_type.nix {
        inherit
            lib
            localTypes
            mkNullOption
            nonNullSubmodule
            ;
    };
in
{
    options.nix-hyprland.rules.layer = mkOption {
        type = types.attrsOf layerRuleType;
        default = { };
    };
}
