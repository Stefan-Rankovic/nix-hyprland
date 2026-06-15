<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<!-- SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me> -->

# Unimplemented Features

## Notifications

They do not exist inside this project. I simply see no need in implementing
them, as I don't see where they would be used. They can only be used to push a
one-time notification, because `if` blocks don't exist either (I'm not sure if
they're even supported in Hyprland itself). And there are various better methods
to do that (notification managers). The only use case I see for them is as a
keybind effect, but that's taken care of by the
[`raw_lua` dispatcher](./dispatchers.md#raw-lua). In any case you're better
using a notification manager (even said on the
[wiki](https://wiki.hypr.land/Configuring/Advanced-and-Cool/Notifications/)
note).

If anyone were to find a use case for it, please open an issue! I'll try to
implement it.

## Environment Variables

This feature does not and will probably never exist in nix-hyprland. Because it
is unnecessary. That feature in Hyprland mainly exists for non-UWSM users, and
nix-hyprland enforces the opposite.

See
[the UWSM documentation](https://github.com/Vladimir-csp/uwsm?tab=readme-ov-file#4-environments-and-shell-profile)
on this.

## Other

Other unimplemented features I'm planning to implement include:

- Layouts
- Animations
- Gestures
- Devices
- Permissions
- Plugins

## Why?

They are not yet implemented because I've had (subjectively) better things to do
in the meantime, including writing this documentation! Also, I don't use any of
those features. So they're lower on the priority list.

## Solution

This problem is not complicated to solve. You can do one of:

- Use the feature in Home Manager (with `wayland.windowManager.hyprland`). I
  recommend this because it's not complicated and you can use the feature now.
  See [Native Home Manager](./configuring.md#native-home-manager).
- Use `extraLuaConfigPre` or `extraLuaConfigPost`. See
  [Lua](./configuring.md#lua).
- Wait for me to implement the feature. I do not recommend this.
