# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    mkNullOption,
    nonNullSubmodule,
}:

let
    inherit (lib) types;
in
types.either types.ints.unsigned (nonNullSubmodule {
    options = {
        top = mkNullOption { type = types.ints.unsigned; };
        left = mkNullOption { type = types.ints.unsigned; };
        right = mkNullOption { type = types.ints.unsigned; };
        bottom = mkNullOption { type = types.ints.unsigned; };
    };
})
