# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{ lib }:

let
    inherit (lib) types;
in
types.either (types.ints.between 100 1000) (
    types.enum [
        "thin"
        "ultralight"
        "light"
        "semilight"
        "book"
        "normal"
        "medium"
        "semibold"
        "bold"
        "ultrabold"
        "heavy"
        "ultraheavy"
    ]
)
