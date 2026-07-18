# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    cfg,
    filterNullsRecursive,
    lib,
}:

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
    ) cfg.rules.window
)
