# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    mkNullOption,
}:

let
    inherit (lib) types;
in
{
    overlay = mkNullOption {
        type = types.bool;
        description = "Print the debug performance overlay. Disable VFR for accurate results.";
    };

    damage_blink = mkNullOption {
        type = types.bool;
        description = "Flash areas updated with damage tracking. **Epilepsy warning.**";
    };

    gl_debugging = mkNullOption {
        type = types.bool;
        description = "Enable OpenGL debugging with `glGetError` and `EGL_KHR_debug`. Requires a restart after changing.";
    };

    vfr = mkNullOption {
        type = types.bool;
        description = "Controls the VFR status of Hyprland. Heavily recommended to leave enabled to conserve resources.";
    };

    disable_logs = mkNullOption {
        type = types.bool;
        description = "Disable logging to a file.";
    };

    disable_time = mkNullOption {
        type = types.bool;
        description = "Disable time logging.";
    };

    damage_tracking = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            Redraw only the parts of the display that need updating.
            - `0`: None.
            - `1`: Monitor.
            - `2`: Full (default, do not change).
        '';
    };

    enable_stdout_logs = mkNullOption {
        type = types.bool;
        description = "Enable logging to stdout.";
    };

    manual_crash = mkNullOption {
        type = types.ints.between 0 1;
        description = "Set to `1` and then back to `0` to crash Hyprland.";
    };

    suppress_errors = mkNullOption {
        type = types.bool;
        description = "If `true`, do not display config file parsing errors.";
    };

    watchdog_timeout = mkNullOption {
        type = types.ints.unsigned;
        description = "Timeout in seconds for the watchdog to abort processing of a signal on the main thread. Set to `0` to disable.";
    };

    disable_scale_checks = mkNullOption {
        type = types.bool;
        description = "Disable verification of scale factors. Will result in pixel alignment and rounding errors.";
    };

    error_limit = mkNullOption {
        type = types.ints.unsigned;
        description = "Limits the number of displayed config file parsing errors.";
    };

    error_position = mkNullOption {
        type = types.ints.between 0 1;
        description = ''
            Sets the position of the error bar.
            - `0`: Top.
            - `1`: Bottom.
        '';
    };

    colored_stdout_logs = mkNullOption {
        type = types.bool;
        description = "Enable colors in the stdout logs.";
    };

    pass = mkNullOption {
        type = types.bool;
        description = "Enable render pass debugging.";
    };

    full_cm_proto = mkNullOption {
        type = types.bool;
        description = "Claim support for all color management protocol features. Requires a restart.";
    };

    invalidate_fp16 = mkNullOption {
        type = types.ints.between 0 2;
        description = ''
            Allow FP16 buffer invalidation. Invalidation increases performance but produces glitches on some systems.
            - `0`: Not allowed.
            - `1`: Allowed.
            - `2`: Not allowed on Nvidia.
        '';
    };
}
