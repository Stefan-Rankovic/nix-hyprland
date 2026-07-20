<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<!-- SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me> -->

# Rules

This section includes window, layer, and workspace rules.

## Basic Syntax

They are all defined with attribute sets. For window and layer rules, the name
of an element represents the name of the rule. For workspace rules (because they
are all unnamed), the name of an element represents what workspace(s) to match
to.

```nix
programs.nix-hyprland.rules = {
    window."float-kitty" = {
        match.initialClass = "kitty"; # Matching on multiple things is supported
        effects.static.float = true; # Multiple effects are supported
    };
    workspace."3".effects = { ... }; # No `match` because that's the "3"
};
```

## Naming

This section does not apply to workspace rules, because they are all unnamed.

To define unnamed window or layer rules, use a list:

```nix
programs.nix-hyprland.rules.unnamed.window = {
    {
        match.initialClass = "kitty";
        effects.static.fullscreen = true;
    }
    {
        match.initialClass = "firefox";
        effects.dynamic.stay_focused = true;
    }
};
```

## Effects

For **window rules**, in order to define an effect, you must know whether it is
static or dynamic. As seen above, to access an effect,
`effects.static.effectName` is used, not `effects.effectName`.

For the `effects.dynamic.opacity` effect, see [Opacity](./types.md#opacity).

## Disabling

To disable a rule, you could add `enable = false;` instead of commenting it out.
