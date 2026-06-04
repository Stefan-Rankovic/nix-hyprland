# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    localTypes,
    mkNullOption,
}:

{
    namespace = mkNullOption {
        type = localTypes.regex;
        description = "Namespace of the layer. Check `hyprctl layers`.";
    };
}
