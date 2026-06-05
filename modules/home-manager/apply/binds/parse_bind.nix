# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    bind,
    config,
    filterNullsRecursive,
    lib,
    luaFunctionArguments,
    keys,
}:

let
    cfg = config.nix-hyprland;

    # === Keys ===
    useMainMod = (bind.useMainMod == true) || (bind.useMainMod != false && cfg.binds.mainMod.enable);
    actualKeys = if useMainMod then "${cfg.binds.mainMod.value} + ${keys}" else keys;

    # === Dsp ===
    dspCallLua = import ../dispatchers/parse_dispatcher.nix {
        inherit
            filterNullsRecursive
            lib
            luaFunctionArguments
            ;
        dispatcher = bind.dsp;
    };

    # === All arguments ===
    allArgumentsList = [
        actualKeys
        dspCallLua
    ]
    ++ lib.optional (bind.flags != null) (filterNullsRecursive bind.flags);
    allArgumentsString = luaFunctionArguments allArgumentsList;
in
if cfg.binds.mainMod.enable && (lib.hasPrefix cfg.binds.mainMod.value keys) then
    throw "nix-hyprland: bind \"${keys}\" begins with mainMod."
else if bind.enable then
    "hl.bind(${allArgumentsString})"
else
    "-- Bind \"${actualKeys}\" disabled"
