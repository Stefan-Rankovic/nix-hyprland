# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    config,
    filterNullsRecursive,
    lib,
}:

let
    cfg = config.nix-hyprland;
in
lib.concatStringsSep "\n" (
    lib.mapAttrsToList (
        name: rule:
        import ./parse_rule.nix {
            inherit
                filterNullsRecursive
                lib
                name
                rule
                ;
        }
    ) cfg.rules.layer
)
