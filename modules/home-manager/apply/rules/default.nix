# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    cfg,
    filterNullsRecursive,
    lib,
}:

let
    layerRules = import ./layer { inherit cfg filterNullsRecursive lib; };
    windowRules = import ./window { inherit cfg filterNullsRecursive lib; };
    workspaceRules = import ./workspace { inherit cfg filterNullsRecursive lib; };

    unnamedRules = import ./unnamed.nix { inherit cfg filterNullsRecursive lib; };
in
lib.concatStringsSep "\n" [
    layerRules
    windowRules
    workspaceRules

    unnamedRules
]
