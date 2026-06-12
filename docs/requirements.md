<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<!-- SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me> -->

# Requirements

There are only two things you need for nix-hyprland. They are
[NixOS](https://nixos.org) and
[Home Manager](https://github.com/nix-community/home-manager).

## NixOS

Actually, I'm not really sure whether it is required or not. But I use NixOS and
made this for myself. If you can get it working on another Linux distribution,
amazing! But I can't guarantee anything.

## Home Manager

It is required for actual [configuration](./configuring.md). Without Home
Manager, this flake is essentially useless: you're better off not using it.
Technically, though, it is possible to use this flake without using Home
Manager.
