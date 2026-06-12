# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    config,
    lib,
    localTypes,
    mkNullOption,
    mkNullSubmodule,
    oneNonNullSubmodule,
    ...
}:

let
    inherit (lib) mkEnableOption mkOption types;

    cfg = config.nix-hyprland;

    bindType = import ./bind_type.nix {
        inherit
            lib
            localTypes
            mkNullOption
            mkNullSubmodule
            oneNonNullSubmodule
            ;
    };
in
{
    config = lib.mkIf cfg.enable {
        assertions = [
            {
                assertion = true;
                message = "nix-hyprland: Must either set `binds.mainMod.enable` to `true` or set `binds.mouse.keys` (because `binds.mouse.enable` is `true`)!";
            }
        ];
    };

    options.nix-hyprland.binds =
        lib.attrsets.unionOfDisjoint (import ./config.nix { inherit lib mkNullOption; })
            {
                mainMod = {
                    enable = mkOption {
                        type = types.bool;
                        default = false;
                        example = true;
                        description = "Whether to prefix every keybind's keys with `mainMod.value` (individual binds can still opt out).";
                    };
                    value = mkOption {
                        type = types.nonEmptyStr;
                        default = "SUPER";
                        example = "SUPER + SHIFT";
                        description = "Key(s) to press before every bind (can be disabled per-bind).";
                    };
                };
                mouse = {
                    enable = mkEnableOption "LMB and RMB (can be overriden individually)";
                    lmb = {
                        enable = mkNullOption {
                            type = types.bool;
                            description = "Whether to enable left click. If null, uses `mouse.enable`.";
                        };
                        action = mkOption {
                            type = types.enum [
                                "drag"
                                "resize"
                            ];
                            default = "drag";
                            example = "resize";
                            description = "Which dispatcher LMB binds to.";
                        };
                    };
                    rmb = {
                        enable = mkNullOption {
                            type = types.bool;
                            description = "Whether to enable right click. If null, uses `mouse.enable`.";
                        };
                        action = mkOption {
                            type = types.enum [
                                "drag"
                                "resize"
                            ];
                            default = "resize";
                            example = "drag";
                            description = "Which dispatcher RMB binds to.";
                        };
                    };
                    mmb = {
                        enable = mkOption {
                            type = types.bool;
                            default = false;
                            description = "Whether to enable the middle click. If null, uses `mouse.enable`.";
                        };
                        action = mkOption {
                            type = types.enum [
                                "drag"
                                "resize"
                            ];
                            default = "drag"; # Chosen because it's alphabetically before `resize`, not because of anything important
                            example = "resize";
                            description = "Which dispatcher MMB binds to.";
                        };
                    };
                    keys = mkNullOption {
                        type = types.nonEmptyStr;
                        description = "What keys to press together with a mouse click. A value of `null` will use `mainMod.value` if `mainMod.enable` is `true`, otherwise it will error.";
                    };
                };
                list = mkOption {
                    type = types.attrsOf (types.either bindType (types.listOf bindType));
                    default = { };
                };
            };
}
