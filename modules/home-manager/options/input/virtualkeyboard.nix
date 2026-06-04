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
    share_states = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            Unify key down states and modifier states with other keyboards.
            - `0`: No.
            - `1`: Yes
            - `2`: Yes unless IME client.'';
    };

    release_pressed_on_close = mkNullOption {
        type = types.bool;
        description = "Release all pressed keys by virtual keyboard on close.";
    };
}
