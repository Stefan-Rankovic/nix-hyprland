<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<!-- SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me> -->

# Dispatchers

Examples on how to use one in a bind can be seen in [Binds](./binds.md). This
section will focus on using them directly (`hl.dispatch` in Hyprland) and their
general syntax.

Using them in a `dispatch` call would run the action at Hyprland startup. An
example would be:

```nix
programs.nix-hyprland.dispatchers = [
    { submap.name = "custom_submap"; }
    { cursor.move = { x = 1000; y = 1000; }; }
];
```

## No Arguments

There are some dispatchers that can take no arguments (e.g. `exit` or
`window.kill`). They are used by setting their value to an empty attribute set
(`{}`). For example:

```nix
programs.nix-hyprland = {
    dispatchers = [
        { exit = {}; }
    ];
    binds.list."SUPER + M".dsp.window.kill = {};
};
```

## Raw Lua

There's also a dispatcher in nix-hyprland you won't find on the Hyprland wiki,
and it's `raw_lua`. If you are normally configuring Hyprland you won't even need
it as you have direct access to Lua code. But here you don't. To use it, you can
do (copied from the `dpms` dispatcher description):

```nix
programs.nix-hyprland.binds."...".dsp.raw_lua = ''
    function()
        hl.timer(function()
            hl.dispatch(hl.dsp.dpms({ action = "disable" }))
        end, {timeout = 500, type = "oneshot"})
    end
'';
```

> [!IMPORTANT]
> Don't forget to wrap the contents with `function() ... end` or else you will
> get an error!
