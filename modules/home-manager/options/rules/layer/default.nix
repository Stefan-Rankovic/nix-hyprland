# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    forceNonNullIn,
    lib,
    localTypes,
    mkNullOption,
    ...
}:

let
    inherit (lib) mkOption types;

    layerRuleType = import ./layer_rule_type.nix {
        inherit
            forceNonNullIn
            lib
            localTypes
            mkNullOption
            ;
    };
in
{
    options.nix-hyprland.rules.layer = mkOption {
        type = types.attrsOf layerRuleType;
        default = { };
    };
}
