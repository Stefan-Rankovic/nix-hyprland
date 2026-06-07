# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    filterNullsRecursive,
    rule,
    name,
    lib,
}:
assert builtins.isFunction filterNullsRecursive;
assert builtins.isAttrs rule;
assert builtins.isString name || name == null;

let
    merged = lib.foldl' lib.attrsets.unionOfDisjoint { } [
        {
            inherit (rule) match;
        }
        rule.effects
        (lib.optionalAttrs (name != null) { inherit name; })
    ];

    filtered = filterNullsRecursive merged;
in
if rule.enable then
    "hl.layer_rule(${lib.generators.toLua { } filtered})"
else
    "-- Layer rule with name \"${name}\" disabled"
