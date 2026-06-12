<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<!-- SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me> -->

# Options

Options listed here do not end up in the resulting Lua file. They instead
configure things outside it.

## NixOS

`package` and `portalPackage` represent the Hyprland and
xdg-desktop-portal-hyprland packages respectively.

`uwsm.runner` (a package) is a runner (for GUI applications) that integrates
with UWSM for all users.

## Home Manager

`package` represents the Hyprland package to use. It should not be set if the
NixOS module is also being used, which is why it's `null` by default.

`uwsm.runner` (a package) is a runner (for GUI applications) that integrates
with UWSM for one user only. Can be used with the NixOS module `uwsm.runner`,
you will just have both runners in your `PATH`.
