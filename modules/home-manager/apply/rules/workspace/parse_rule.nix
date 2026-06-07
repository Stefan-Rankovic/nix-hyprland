# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    filterNullsRecursive,
    lib,
    rule,
    workspace,
}:
assert builtins.isFunction filterNullsRecursive;
assert builtins.isAttrs rule;
assert builtins.isString workspace;

let
    mergedWithNulls = lib.attrsets.unionOfDisjoint rule.effects {
        inherit workspace;
    };

    merged = filterNullsRecursive mergedWithNulls;
in
if rule.enable then
    "hl.workspace_rule(${lib.generators.toLua { } merged})"
else
    "-- Workspace rule that matches \"${workspace}\" disabled"
