# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
    oneNonNullSubmodule,
}:

oneNonNullSubmodule {
    options = import ./all.nix {
        inherit
            lib
            localTypes
            mkNullOption
            mkNullSubmodule
            oneNonNullSubmodule
            ;
    };
}
