# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    config,
    filterNullsRecursive,
    lib,
}:

let
    layerRules = import ./layer { inherit config filterNullsRecursive lib; };
    windowRules = import ./window { inherit config filterNullsRecursive lib; };
in
lib.concatStringsSep "\n" [
    layerRules
    windowRules
]
