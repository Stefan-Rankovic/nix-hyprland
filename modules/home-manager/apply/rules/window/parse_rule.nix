# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    filterNullsRecursive,
    rule,
    name,
    lib,
}:

let
    baseMergedWithNulls = lib.foldl' lib.attrsets.unionOfDisjoint { } [
        {
            inherit name;
            inherit (rule) match;
        }
        rule.effects.static
        rule.effects.dynamic
    ];

    baseMerged = filterNullsRecursive baseMergedWithNulls;

    opacitySingle =
        {
            value,
            override,
        }:
        "${toString value}${if override then " override" else ""}";
    opacityAll =
        opacity:
        let
            active = opacitySingle opacity.active;
            inactive = opacitySingle opacity.inactive;
            fullscreen = opacitySingle opacity.fullscreen;
        in
        "${active} ${inactive} ${fullscreen}";

    handleGroup =
        group:
        let
            actualGroup =
                group
                // lib.optionalAttrs (builtins.hasAttr "set" group) {
                    set = if builtins.hasAttr "always" group.set then "set always" else "set";
                }
                // lib.optionalAttrs (builtins.hasAttr "lock" group) {
                    set = if builtins.hasAttr "always" group.lock then "lock always" else "lock";
                };
            convert =
                name: value:
                if value == true then
                    name
                else if builtins.isString value then
                    value
                else
                    throw "group has a value other than true or a string. That shouldn't be possible";
        in
        lib.concatStringsSep " " builtins.attrValues (builtins.mapAttrs convert actualGroup);

    merged =
        baseMerged
        // (lib.optionalAttrs (builtins.hasAttr "opacity" baseMerged) {
            opacity = opacityAll rule.effects.dynamic.opacity;
        })
        // (lib.optionalAttrs (builtins.hasAttr "group" baseMerged) {
            group = handleGroup rule.effects.static.group;
        });
in
if rule.enable then
    "hl.window_rule(${lib.generators.toLua { } merged})"
else
    "-- Window rule \"${name}\" disabled"
