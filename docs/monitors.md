<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<!-- SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me> -->

# Monitors

<!-- todo: maybe define them as an attribute set? -->

Monitors are defined as a list of attribute sets.

Defining a simple monitor might look like (example values gotten from the
Hyprland wiki):

```nix
programs.nix-hyprland.monitors = [
    {
        output = "DP-1";
        mode = "1920x1080@144";
        position = "0x0";
        scale = 1.0;
    }
];
```
