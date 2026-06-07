# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    mkNullOption,
    nonNullSubmodule,
}:

let
    inherit (lib) mkOption types;

    # === Enable ===
    enableOption = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to enable this `workspace_rule`.";
    };

    # === Effects ===
    # Type
    effectsType = nonNullSubmodule {
        options = import ./effects.nix { inherit lib mkNullOption; };
    };
    # Option
    effectsOption = mkOption {
        type = effectsType;
        default = { };
        description = "Effects to apply to workspaces falling under this `workspace_rule`. See [the hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/).";
    };
in
types.submodule {
    options = {
        enable = enableOption;
        effects = effectsOption;
    };
}
