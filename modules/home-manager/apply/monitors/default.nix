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
    map (
        monitor:
        import ./parse_monitor.nix {
            inherit
                filterNullsRecursive
                lib
                monitor
                ;
        }
    ) cfg.monitors
)
