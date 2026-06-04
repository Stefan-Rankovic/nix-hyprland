<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<!-- SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me> -->

# Nix-hyprland

## Description

A tool to configure [Hyprland](hypr.land) using Nix.

> [!IMPORTANT]
> For basic use, this is ready. But some things are broken, improperly
> documented, or just not implemented yet. I just wanted to get this pushed to
> GitHub as soon as possible and will fix/document/implement a lot of things in
> the next few days.

## Requirements

- [NixOS](https://nixos.org/)[^1]
- [Home Manager](https://github.com/nix-community/home-manager)[^2]

[^1]: I'm not really sure whether it is really required or not, but I use NixOS
    and made this for myself. If you can get it working on another Linux
    distribution, amazing! But I can't guarantee anything.

[^2]: Not really a hard requirement. The installation will complete
    successfully. But 99% of the features this flake provides are only
    accessible with it.

## Installation

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

### NixOS Module

Import `inputs.nix-hyprland.nixosModules.default` somewhere inside your NixOS
module configuration, and set some options inside it:

```nix
nix-hyprland = {
    enable = true;
    uwsm.runner = pkgs.runapp; # Faster than `uwsm app --`
};
```

#### UWSM

> [!WARNING]
> Enabling nix-hyprland automatically sets up
> [UWSM](https://github.com/Vladimir-csp/uwsm).
>
> If you don't like that, sadly nix-hyprland isn't for you.

### Home Manager

If you are also using Home Manager (which is recommended), import
`inputs.nix-hyprland.homeManagerModules.default` somewhere inside your Home
Manager configuration.

## Configuration

> [!NOTE]
> The following options are defined in Home Manager, not the NixOS module.

Nix-hyprland lets _you_ do all the configuring, with no defaults at all.
Seriously, it produces a completely empty Lua file by default!

> [!WARNING]
> To make that possible, all options in nix-hyprland are `null` by default.
>
> Because of that, setting them to `null` changes nothing, and will **not**
> cause the resulting Lua file to contain a value of `nil` in that place.

### Lua

If you are dissatisfied with how something is done, or it doesn't exist yet, or
is bugged, you can use `extraLuaConfigPre` and `extraLuaConfigPost` to add your
own Lua config.

If you choose to use those two options, you can still, of course, use the rest
of the options.

### Options

Options like `general.border_size` or `input.touchdevice.enabled` (or similar)
can be configured like

```nix
nix-hyprland = {
    decoration.rounding_power = 3.7;
    general.border_size = 10;
    input.touchdevice.enabled = true;
};
```

The list of available options can be seen on
[the Hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Variables/).

### Monitors

The monitors are defined as a list of attribute sets.

Defining a simple monitor might look like (example values gotten from the
Hyprland wiki):

```nix
nix-hyprland.monitors = [
    {
        output = "DP-1";
        mode = "1920x1080@144";
        position = "0x0";
        scale = 1.0;
    }
];
```

For more available options, see
[the Hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Monitors/).

### Binds

These are configured using attribute sets (unlike the default in Home Manager
which uses lists, adding one extra indentation level for no reason). For
example:

```nix
# The option is named `binds.list`, but the type is an attribute set
nix-hyprland.binds.list = {
    "SUPER + T".dsp.exec_cmd.cmd = "uwsm app -- kitty";
    "SUPER + B".dsp.exec_cmd.cmd = "uwsm app -- firefox";
};
```

Which would create two binds, one that opens Kitty when `SUPER + T` is pressed,
and another that opens Firefox when `SUPER + B` is pressed.

> [!TIP]
> To temporarily disable a bind for any reason, you don't have to comment it
> out. Instead, you can do:
>
> ```nix
> nix-hyprland.binds.list."SUPER + T" = {
>     enable = false;
>     dsp.exec_cmd.cmd = "uwsm app -- kitty";
> };
> ```
>
> Which will put `-- Bind "SUPER + T" disabled` inside the resulting Lua file
> instead of the actual bind.

#### Main Mod

Prefixing binds with `SUPER` is such a common occurrence (at least for me),
there's actually a shortcut for it. The above configuration is functionally
equivalent to:

```nix
nix-hyprland.binds = {
    mainMod.enable =true;
    list = {
        "T".dsp.exec_cmd.cmd = "uwsm app -- kitty";
        "B".dsp.exec_cmd.cmd = "uwsm app -- firefox";
    };
};
```

> [!TIP]
> Don't like `SUPER`? Want something else? Just set
> `nix-hyprland.binds.mainMod.value` to any modifiers (it doesn't have to be
> singular) you want.

But you may also want to add a bind that does not use your preferred `mainMod`.
For example, binding `XF86AudioRaiseVolume`. In that case, you don't have to
remove `mainMod` from your configuration, instead you can set
`useMainMod = false` per bind:

```nix
nix-hyprland.binds.list."XF86AudioRaiseVolume" = {
    useMainMod = false;
    dsp.exec_cmd.cmd = "...";
};
```

#### Mouse Binds

Unlike what you might expect, you can **not** bind mouse keys to `resize()` or
`drag()` (unless you use the `raw_lua` dispatcher), since those dispatchers
don't exist here (the `resize()` dispatcher exists, but it takes arguments, and
it's not the one for the mouse). I imagine a lot of people would want to do
that. Which is why there's an alias for it! If you set
`nix-hyprland.binds.mouse.enable = true;`, `mainMod.value + mouse:272`
(left-click) will get bound to `drag()` and `mainMod.value + mouse:273`
(right-click) will get bound to `resize()`.

To swap that behavior, you can do:

```nix
nix-hyprland.binds.mouse = {
    lmb.action = "resize";
    rmb.action = "drag";
};
```

The middle mouse button is not bound by default. You can enable it with
`nix-hyprland.binds.mouse.mmb.enable = true;` which will bind it to `drag` by
default. You can change that to `resize` using the same syntax as above
(`nix-hyprland.binds.mouse.mmb.action = "resize";`).

`mainMod.value` is used because just binding left-click or right-click makes no
sense. If `mainMod.enable` is `false` though, you will get an error! To avoid
that, you can set `nix-hyprland.binds.mouse.keys` to a string (e.g. `"ALT"` or
`"SUPER"`).

> [!CAUTION]
> When setting `mouse.enable = true;` there must not be any other bind that sets
> the bind to the same key combination. For example, this is not allowed:
>
> ```nix
> nix-hyprland.binds = {
>     mouse.enable = true;
>     mainMod.enable = true;
>     list."mouse:272" = { ... };
> };
> ```

### Multiple Binds Per Key

You may want to bind some key combination to use two dispatchers (or the same
dispatcher twice). Unfortunately that is not possible by simply doing something
like:

```nix
nix-hyprland.binds.list."...".dsp = {
    exec_cmd.cmd = "...";
    window.kill = {};
};
```

Because only one dispatcher is valid per bind.

Instead, what you can do, is define a bind to be a list of attribute sets:

```nix
nix-hyprland.binds.list."..." = [
    { exec_cmd.cmd = "..."; }
    { window.kill = {}; }
];
```

### Dispatchers

In the [Binds](#binds) section above, you could see there's a `dsp` field for
every bind. That's short for dispatchers.

#### Usage

You can use them in binds as actions, or you can directly run them on Hyprland
startup. The latter would look like:

```nix
nix-hyprland.dispatchers = [
    { submap.name = "custom_submap"; }
    { cursor.move = { x = 1000; y = 1000; }; }
];
```

There are some dispatchers that take no arguments (e.g. `exit` or `window.kill`
(the latter does take one argument but it's optional)). For example, to use one
in a bind, you would do `nix-hyprland.binds.list."...".dsp.exit = {};` (don't do
that though because of UWSM, this is an example to show syntax, not
functionality) or `nix-hyprland.binds.list."...".dsp.window.kill = {};`.

> [!WARNING]
> Using them should be fine, but since I don't use most of them, they aren't
> really tested.
>
> If you encounter one that doesn't work, please open an issue!

#### List

There's a lot of them, and their documentation can be found on
[the Hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Dispatchers/).

#### Raw Lua

There's also a dispatcher in nix-hyprland you won't find on the Hyprland wiki,
and it's `raw_lua`. If you are normally configuring Hyprland you won't even need
it as you have direct access to Lua code. But here you don't. To use it, you can
do (copied from the `dpms` dispatcher description):

```nix
nix-hyprland.binds."...".dsp.raw_lua = ''
    function()
        hl.timer(function()
            hl.dispatch(hl.dsp.dpms({ action = "disable" }))
        end, {timeout = 500, type = "oneshot"})
    end)
'';
```

> [!IMPORTANT]
> Don't forget to wrap it with `function() ... end` or else Lua will complain.

### Rules

Rules are split into two groups—window rules and layer rules.

Neither unnamed window rules nor unnamed layer rules are supported (for those
you'd have to use `extraLuaConfigPre` or `extraLuaConfigPost`). This is a todo.

Disabling rules is the same as disabling binds. Instead of commenting them out,
just add `enable = false;`.

#### Window

These are also, unlike in Home Manager, defined with attribute sets. To define a
window rule that makes all Kitty windows float, you can do:

```nix
nix-hyprland.rules.window."float-kitty" = {
    match.initialClass = "kitty";
    effects.static.float = true;
};
```

##### Match

This part defines what the window rule applies to. There are a lot of options
here, all of which available on
[the Hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#props).

##### Effects

This part defines what the window rule actually does. Available options can be
seen on
[the Hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#effects).

> [!WARNING]
> `effects.stay_focused` does not exist. `effects.dynamic.stay_focused` does.
>
> To set an effect, first check on the Hyprland wiki whether it's a static or
> dynamic effect and define the window rule accordingly.

###### Opacity

In Hyprland, opacity is just a string. But here it is an attribute set to be
declaratively set. In Hyprland, what would be `"1.0 0.5 0.9"` is here:

```nix
{
    active.value = 1.0;
    inactive.value = 0.5;
    fullscreen.value = 0.9;
}
```

All three of those options are required.

Translating `"0.5 override 1.0 0.1"` would look like:

```nix
{
    active = {
        value = 0.5;
        override = true;
    };
    inactive = 1.0;
    fullscreen = 0.1;
}
```

`override` exists because `active.value = 0.5` does not mean that the window's
opacity will be `0.5`, but that the previously set opacity will be multiplied by
`0.5`. So two separate window rules setting the opacity to `0.5` will make the
opacity of a window that fulfills both `0.25`. For example, the opacity of an
active floating `Kitty` window will be `0.15` using this configuration (because
`0.3 * 0.5 = 0.15`):

```nix
nix-hyprland.rules.window = {
    "kitty" = {
        match.initialClass = "kitty";
        effects.dynamic.opacity.active.value = 0.5;
    };
    "floating" = {
        match.float = true;
        effects.dynamic.opacity.active.value = 0.3;
    };
};
```

Because of that, an opacity can also be set to more than `1.0`. For example, the
opacity of an active floating `Kitty` window will be `0.6` using this
configuration:

```nix
nix-hyprland.rules.window = {
    "kitty" = {
        match.initialClass = "kitty";
        effects.dynamic.opacity.active.value = 2.0;
    };
    "floating" = {
        match.float = true;
        effects.dynamic.opacity.active.value = 0.3;
    };
};
```

> [!CAUTION]
> Be careful when doing setting an opacity over `1.0`, since (using the above
> example) an active non-floating `Kitty` window will have an opacity of `2.0`.
> Any opacity over `1.0` causes graphical glitches.

#### Layer

Some things in Wayland are not windows, but layers (e.g. app launchers, status
bars, wallpapers). These are separately configured using
`nix-hyprland.rules.layer`.

##### Match (Layer)

Layer rules can match on only one thing—`namespace`.

##### Effects (Layer)

Available effects can be seen on
[the Hyprland wiki](https://wiki.hypr.land/Configuring/Basics/Window-Rules/#effects-1).

Unlike window rule effects, these are not split into `static` and `dynamic`. It
does not say on the Hyprland wiki explicitly, but looking at the descriptions of
the effects, I'm pretty sure all of them are `static`.

### Other

I don't use lots of other features like animations, gestures, etc. Which is why
they're not here (this is a todo).

What you can do about this is fork the repository and implement it on your own,
put things inside `extraLuaConfigPre` or `extraLuaConfigPost`, or wait for me to
implement them (I wouldn't count on the last option).

## License

This project is licensed under GPL-3.0-or-later and is REUSE-compliant.

> [!NOTE]
> The resulting Lua file generated by this tool is owned by you (the user), not
> this tool (which is nonsense anyway) or me. Thus, it is not subject to the
> project's license and you are free to do whatever you want with it.
