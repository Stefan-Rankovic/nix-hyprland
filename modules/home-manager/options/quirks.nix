# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    mkNullOption,
}:

let
    inherit (lib) types;
in
{
    prefer_hdr = mkNullOption {
        type = types.bool;
        description = ''
            Report HDR mode as preferred.
            - `0`: Off.
            - `1`: Always.
            - `2`: Gamescope only.
        '';
    };
}
