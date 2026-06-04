# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    forceNonNullIn,
    lib,
    mkNullOption,
}:

let
    inherit (lib) mkOption types;

    color = import ./color.nix { inherit forceNonNullIn lib mkNullOption; };
in
types.submodule {
    options = {
        colors = mkOption {
            type = types.addCheck (types.listOf color) (v: builtins.length v >= 1);
            description = "List of colors in the gradient.";
        };
        angle = mkNullOption { type = types.ints.unsigned; };
    };
}
