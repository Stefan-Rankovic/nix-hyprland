<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<!-- SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me> -->

# Types

There are some types in Hyprland that do not directly translate to Nix types in
nix-hyprland.

## Opacity

In Hyprland, the value of `opacity` is just a string. But here it is an
attribute set to be declaratively set.

In Hyprland, what would be `"1.0 0.5 0.9"` is here:

```nix
{
    active.value = 1.0; # You can leave this out, since 1.0 is the default
    inactive.value = 0.5;
    fullscreen.value = 0.9;
}
```

If you leave out an option, it defaults to `1.0`.

`"0.5 override 1.0 0.1"` would look like:

```nix
{
    active = {
        value = 0.5;
        override = true;
    };
    fullscreen.value = 0.1;
}
```

There's another way. If you don't like attribute sets, you can set the opacity
to something like `0.5` (as a float, not string). That will pass it directly to
Hyprland as a single value.
