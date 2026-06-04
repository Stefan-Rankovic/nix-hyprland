# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    mkNullOption,
}:

let
    inherit (lib) mkOption types;

    mkNullBool =
        description:
        mkNullOption {
            inherit description;
            type = types.bool;
        };
in
{
    locked = mkNullBool "Will also work when an input inhibitor (e.g. a lockscreen) is active.";

    release = mkNullBool "Will also work when an input inhibitor (e.g. a lockscreen) is active.";

    click = mkNullBool "Will trigger on release of a key or button as long as the mouse cursor stays inside `binds:drag_threshold`.";

    drag = mkNullBool "Will trigger on release of a key or button as long as the mouse cursor stays outside `binds:drag_threshold`.";

    long_press = mkNullBool "Will trigger on long press of a key.";

    repeating = mkNullBool "Will repeat when held.";

    non_consuming = mkNullBool "Key/mouse events will be passed to the active window in addition to triggering the dispatcher.";

    auto_consuming = mkNullBool "Key/mouse events will be passed to the active window if the dispatcher doesn’t succeed.";

    mouse = mkNullBool "See the dedicated [Mouse Binds](https://wiki.hypr.land/Configuring/Basics/Binds/#mouse-binds) section.";

    transparent = mkNullBool "Cannot be shadowed by other binds.";

    ignore_mods = mkNullBool "Will ignore modifiers.";

    description = mkNullOption {
        type = types.str;
        description = "Will allow you to write a description for your bind.";
    };

    submap_universal = mkNullBool "Will be active no matter the submap.";

    device = mkNullOption {
        type = types.submodule {
            options = {
                inclusive = mkNullBool ''
                    - `true`: Only devices specified in the list are capable of triggering the keybind.
                    - `false`: All devices except those specified can trigger the keybind.
                '';
                list = mkOption {
                    type = types.listOf types.str;
                    description = ''
                        Device tags may also be used in place of device names. See [Devices](https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices).
                        Also see `inclusive` description for behavior.
                    '';
                };
            };
        };
        description = "Allow binds to be set per device. See [Per-Device Binds](https://wiki.hypr.land/Configuring/Basics/Binds/#per-device-binds).";
    };
}
