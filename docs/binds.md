<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<!-- SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me> -->

# Binds

These are configured using attribute sets. For example:

```nix
# The option is named `binds.list`, but the type is an attribute set
programs.nix-hyprland.binds.list = {
    "SUPER + T".dsp.exec_cmd.cmd = "uwsm app -- kitty";
    "SUPER + B".dsp.exec_cmd.cmd = "uwsm app -- firefox";
};
```

Which would create two binds, one that opens Kitty when `SUPER + T` is pressed,
and another that opens Firefox when `SUPER + B` is pressed.

## Main Mod

I actually prefix my binds with `SUPER` so often, I made a shortcut for that.
The above example configuration has the same output as:

```nix
programs.nix-hyprland.binds = {
    mainMod.enable = true;
    list = {
        "T".dsp.exec_cmd.cmd = "uwsm app -- kitty";
        "B".dsp.exec_cmd.cmd = "uwsm app -- firefox";
    };
};
```

### Other Main Mod Values

Not everyone likes `SUPER`. If you don't, don't fret! You can still use the
`mainMod` feature. Just set `programs.nix-hyprland.binds.mainMod.value` to any
modifiers you want.

`binds.mainMod.values` doesn't have to be a single modifier, it can be multiple
as well. It follows the same syntax as `binds.list."..."`.

> [!CAUTION]
> Keep in mind that if `programs.nix-hyprland.binds.mainMod.enable` is `true`,
> an existing bind can't start with `programs.nix-hyprland.binds.mainMod.value`.
> For example, this is not allowed:
>
> ```nix
> programs.nix-hyprland.binds = {
>     mainMod = {
>         enable = true;
>         value = "ALT";
>     };
>     list = {
>         "ALT + T".dsp.exec_cmd.cmd = "uwsm app -- kitty";
>         "ALT + B" = {
>             useMainMod = false;
>             dsp.exec_cmd.cmd = "uwsm app -- firefox";
>         };
>     };
> }
> ```
>
> Both of those binds will cause an error.

### Exceptions

Some binds should not use the `mainMod`. For example, `XF86AudioRaiseVolume`. In
that case, you can set `useMainMod = false` per bind:

```nix
programs.nix-hyprland.binds.list."XF86AudioRaiseVolume" = {
    useMainMod = false;
    dsp.exec_cmd.cmd = "...";
};
```

If `binds.mainMod.enable` is `false`, `binds.list."...".useMainMod` has no
effect. Vice versa.

## Mouse Binds

The mouse-related `resize()` and `drag()` dispatchers don't exist, so you can't
bind a mouse key to them. Instead, mouse binds are defined using `binds.mouse`,
separate from the other binds in `binds.list`.

Setting `programs.nix-hyprland.binds.mouse.enable` to `true` will bind
"mainMod + left-click" to `drag()` and "mainMod + right-click" to `resize()`. To
swap that behavior, you can do:

```nix
programs.nix-hyprland.binds.mouse = {
    lmb.action = "resize";
    rmb.action = "drag";
};
```

Setting both `mouse.lmb` and `mouse.rmb` to the same thing is also supported.

> [!CAUTION]
> When setting `mouse.enable = true;` there must not be any other bind that sets
> the bind to the same key combination. For example, this is not allowed:
>
> ```nix
> programs.nix-hyprland.binds = {
>     mouse.enable = true;
>     mainMod.enable = true;
>     list."mouse:272" = { ... };
> };
> ```

If binding LMB/RMB is not desirable, you can disable one (or both) of them. An
example configuration like that would be:

```nix
programs.nix-hyprland.binds.mouse = {
    enable = true;
    lmb.enable = false;
};
```

### No Main Mod

`mainMod.value` is used because just binding left-click or right-click makes no
sense. If `mainMod.enable` is `false` though, you will get an error!

To avoid that, you can set `programs.nix-hyprland.binds.mouse.keys` to a string
(e.g. `"ALT"` or `"SUPER"`).

For example, to bind only "ALT + left-click" to `resize()`, you would do:

```nix
# Suppose binds.mainMod.enable is false
programs.nix-hyprland.binds.mouse = {
    keys = "ALT";
    lmb.action = "resize";
    rmb.enable = false;
};
```

### Middle Mouse Button

The middle mouse button is not bound by default. You can enable it with
`programs.nix-hyprland.binds.mouse.mmb.enable = true;` which will bind it to
`drag` by default. You can change that to `resize` using the same syntax as
above (`programs.nix-hyprland.binds.mouse.mmb.action = "resize";`).

## Multiple Binds Per Key

You may want to bind some key combination to use two
[dispatchers](./dispatchers.md) (or the same dispatcher twice). Unfortunately
that is not possible by simply doing something like:

```nix
programs.nix-hyprland.binds.list."...".dsp = {
    exec_cmd.cmd = "...";
    window.kill = {};
};
```

Because only one dispatcher is valid per bind.

Instead, what you should do is define a bind to be a list of attribute sets:

```nix
programs.nix-hyprland.binds.list."..." = [
    { dsp.exec_cmd.cmd = "..."; }
    { dsp.window.kill = {}; }
];
```

## Disabling

To disable a bind, you could add `enable = false;` instead of commenting it out.
