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
    imports = [
        ./options.nix
    ];

    config = lib.mkMerge [
        { _module.args = { inherit checkHyprlandVersion; }; }
        (lib.mkIf cfg.enable {
            programs.hyprland = {
                inherit (cfg)
                    enable
                    package
                    portalPackage
                    ;
                withUWSM = true;
            };

            environment.systemPackages = lib.optional (cfg.uwsm.runner != null) cfg.uwsm.runner;
        })
    ];
}
