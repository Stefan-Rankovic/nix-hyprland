# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    cfg,
    filterNullsRecursive,
    lib,
    luaFunctionArguments,
}:

lib.concatStringsSep "\n" (
    map (
        dispatcher:
        import ./parse_dispatcher.nix {
            inherit
                dispatcher
                filterNullsRecursive
                lib
                luaFunctionArguments
                ;
        }
    ) cfg.dispatchers
)
