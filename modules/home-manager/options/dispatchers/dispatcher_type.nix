# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    exactlyOneNonNullSubmodule,
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
}:

exactlyOneNonNullSubmodule {
    options = import ./all.nix {
        inherit
            exactlyOneNonNullSubmodule
            lib
            localTypes
            mkNullOption
            mkNullSubmodule
            ;
    };
}
