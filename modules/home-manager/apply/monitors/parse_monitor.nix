# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    filterNullsRecursive,
    lib,
    monitor,
}:

let
    filtered = filterNullsRecursive monitor;
in
"hl.monitor(${lib.generators.toLua { } filtered})"
