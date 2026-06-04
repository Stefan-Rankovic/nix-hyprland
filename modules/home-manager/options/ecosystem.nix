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
    no_update_news = mkNullOption {
        type = types.bool;
        description = "Disable the popup that appears when Hyprland is updated to a new version.";
    };

    no_donation_nag = mkNullOption {
        type = types.bool;
        description = "Disable the popup that appears twice a year encouraging donations.";
    };

    enforce_permissions = mkNullOption {
        type = types.bool;
        description = "Whether to enable permission control.";
    };
}
