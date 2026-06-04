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
    enabled = mkNullOption {
        type = types.bool;
        description = "Enable animations.";
    };

    workspace_wraparound = mkNullOption {
        type = types.bool;
        description = "Enable workspace wraparound, causing directional workspace animations to animate as if the first and last workspaces were adjacent.";
    };
}
