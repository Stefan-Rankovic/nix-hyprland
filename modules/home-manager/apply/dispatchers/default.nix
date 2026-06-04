# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    config,
    filterNullsRecursive,
    lib,
    luaFunctionArguments,
}:

let
    cfg = config.nix-hyprland;
in
lib.concatStringsSep "\n" (
    map (
        dispatcher:
        import ./parse_dispatcher.nix.nix {
            inherit
                dispatcher
                filterNullsRecursive
                lib
                luaFunctionArguments
                ;
        }
    ) cfg.dispatchers
)
