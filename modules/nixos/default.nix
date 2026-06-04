# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    config,
    lib,
    ...
}:

let
    cfg = config.nix-hyprland;
in
{
    imports = [
        ./options.nix
    ];

    programs.hyprland = {
        inherit (cfg)
            enable
            package
            xwayland
            ;
        withUWSM = true;
    };

    environment.systemPackages = lib.optional (cfg.enable && cfg.uwsm.runner != null) cfg.uwsm.runner;
}
