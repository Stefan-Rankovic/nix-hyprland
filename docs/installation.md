<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<!-- SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me> -->

# Installation

See [Requirements](./requirements.md).

Like every other flake, it must be added to the `inputs` section of your
`flake.nix` file. For example, it could look like:

```nix
# flake.nix
{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nix-hyprland = {
            url = "github:Stefan-Rankovic/nix-hyprland";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        ...
    };

    outputs = ...;
}
```

## NixOS

Import `inputs.nix-hyprland.nixosModules.default` somewhere inside your NixOS
configuration, and set `nix-hyprland.enable` to `true`.

## Home Manager

Import `inputs.nix-hyprland.homeManagerModules.default` somewhere inside your
Home Manager configuration and set `nix-hyprland.enable` to `true`.

## Universal Wayland Session Manager (UWSM)

Using nix-hyprland means using [UWSM](https://github.com/Vladimir-csp/uwsm) too:
it's required.

If you don't like that, sadly nix-hyprland isn't for you.

> [!CAUTION]
> In Home Manager, `wayland.windowManager.hyprland.systemd.enable` will be set
> to `false` because of this. Do not override that! It's intentional because
> UWSM conflicts with that option.
