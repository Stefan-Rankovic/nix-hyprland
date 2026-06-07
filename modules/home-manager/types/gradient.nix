# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    mkNullOption,
    nonNullSubmodule,
}:

let
    inherit (lib) mkOption types;

    color = import ./color.nix { inherit lib mkNullOption nonNullSubmodule; };
in
types.submodule {
    options = {
        colors = mkOption {
            type = types.nonEmptyListOf color;
            description = "List of colors in the gradient.";
        };
        angle = mkNullOption { type = types.ints.unsigned; };
    };
}
