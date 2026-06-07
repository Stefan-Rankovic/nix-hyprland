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

    workspaceRuleType = import ./workspace_rule_type.nix {
        inherit
            lib
            localTypes
            mkNullOption
            nonNullSubmodule
            ;
    };
in
{
    options.nix-hyprland.rules.workspace = mkOption {
        type = types.attrsOf (types.either workspaceRuleType (types.listOf workspaceRuleType));
        default = { };
    };
}
