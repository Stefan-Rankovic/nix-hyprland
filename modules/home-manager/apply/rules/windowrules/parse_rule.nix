# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    filterNullsRecursive,
    rule,
    name,
    lib,
}:

let
    baseMerged = lib.foldl' lib.unionOfDisjoint { } [
        {
            inherit name;
            inherit (rule) match;
        }
        rule.effects.static
        rule.effects.dynamic
    ];

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

    merged =
        baseMerged
        // (lib.optionalAttrs (baseMerged.opacity != null) {
            opacity = opacityAll rule.effects.dynamic.opacity;
        });

    filtered = filterNullsRecursive merged;
in
if rule.enable then
    "hl.window_rule(${lib.generators.toLua { } filtered})"
else
    "-- Window rule \"${name}\" disabled"
