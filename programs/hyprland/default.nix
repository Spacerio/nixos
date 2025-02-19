{ config, pkgs, lib, ... }:

{

  # wayland.windowManager.hyprland = {
  #   enable = true;
  # };

  home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/hyprland/hyprland.conf";
}
