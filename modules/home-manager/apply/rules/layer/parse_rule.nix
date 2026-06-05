# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    filterNullsRecursive,
    rule,
    name,
    lib,
}:

let
    merged = lib.attrsets.unionOfDisjoint {
        inherit name;
        inherit (rule) match;
    } rule.effects;

    filtered = filterNullsRecursive merged;
in
if rule.enable then
    "hl.layer_rule(${lib.generators.toLua { } filtered})"
else
    "-- Layer rule \"${name}\" disabled"
