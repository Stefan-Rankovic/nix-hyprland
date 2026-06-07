# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Stefan Rankovic <stefi.rankovic@proton.me>

{
    doubleElement,
    forceNonNullIn,
    lib,
    mkNullOption,
}:

{
    color = import ./color.nix { inherit forceNonNullIn lib mkNullOption; };
    content_type = import ./content_type.nix { inherit lib; };
    css_gaps = import ./css_gaps.nix { inherit forceNonNullIn lib mkNullOption; };
    direction = import ./direction.nix { inherit lib; };
    font_weight = import ./font_weight.nix { inherit lib; };
    fullscreen_action = import ./fullscreen_action.nix { inherit lib; };
    fullscreen_state = import ./fullscreen_state.nix { inherit lib; };
    gradient = import ./gradient.nix { inherit forceNonNullIn lib mkNullOption; };
    idle_inhibit_rules = import ./idle_inhibit_rules.nix { inherit lib; };
    layout = import ./layout.nix { inherit lib; };
    monitor = import ./monitor.nix { inherit lib; };
    opacity = import ./opacity.nix { inherit lib; };
    regex = import ./regex.nix { inherit lib; };
    unit = import ./unit.nix { inherit lib; };
    vec2 = import ./vec2.nix { inherit doubleElement lib; };
    vrr_mode = import ./vrr_mode.nix { inherit lib; };
    window = import ./window.nix { inherit lib; };
    workspace = import ./workspace.nix { inherit lib; };
}
