# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    cfg,
    filterNullsRecursive,
    lib,
}:

lib.concatStringsSep "\n" (
    lib.mapAttrsToList (
        workspace: rule:
        import ./parse_rule.nix {
            inherit
                filterNullsRecursive
                lib
                rule
                workspace
                ;
        }
    ) cfg.rules.workspace
)
