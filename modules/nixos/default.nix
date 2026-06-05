# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

checkHyprlandVersion:
{
    config,
    lib,
    ...
}:

let
    cfg = config.nix-hyprland;
in
{
    _module.args = { inherit checkHyprlandVersion; };
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
