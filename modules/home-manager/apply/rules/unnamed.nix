# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    cfg,
    filterNullsRecursive,
    lib,
}:

lib.concatStringsSep "\n" (
    (map (
        rule:
        import ./window/parse_rule.nix {
            inherit
                filterNullsRecursive
                lib
                rule
                ;
            name = null;
        }
    ) cfg.rules.unnamed.window)
    ++ (map (
        rule:
        import ./layer/parse_rule.nix {
            inherit
                filterNullsRecursive
                lib
                rule
                ;
            name = null;
        }
    ) cfg.rules.unnamed.layer)
)
