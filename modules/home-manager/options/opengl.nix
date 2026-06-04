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
    nvidia_anti_flicker = mkNullOption {
        type = types.bool;
        description = "Reduces flickering on nvidia at the cost of possible frame drops on lower-end GPUs. On non-nvidia, this is ignored.";
    };
}
