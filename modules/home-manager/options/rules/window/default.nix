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

    windowRuleType = import ./window_rule_type.nix {
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
    options.nix-hyprland.rules.window = mkOption {
        type = types.attrsOf windowRuleType;
        default = { };
    };
}
