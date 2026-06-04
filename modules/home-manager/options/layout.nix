# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    lib,
    localTypes,
    mkNullOption,
}:

let
    inherit (lib) types;
in
{
    single_window_aspect_ratio = mkNullOption {
        type = localTypes.vec2;
        description = "Whenever only a single window is shown on a screen, add padding so that it conforms to the specified aspect ratio. E.g. `{ 4, 3 }` on a 16:9 screen will produce a 4:3 window centered with padding on the sides. `{ 0, 0 }` disables this.";
    };

    single_window_aspect_ratio_tolerance = mkNullOption {
        type = types.numbers.between 0.0 1.0;
        description = "Tolerance for `single_window_aspect_ratio`. If the padding that would have been added is smaller than this fraction of the height or width of the screen, no adjustment is made.";
    };
}
