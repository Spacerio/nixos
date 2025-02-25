{
  config,
  pkgs,
  lib,
  ...
}: {
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   extraConfig = builtins.readFile ./hyprland.conf;
  # };

  home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/hyprland/hyprland.conf";
  home.file.".config/hypr/hyprlock.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/hyprland/hyprlock.conf";
  home.file.".config/hypr/gamemode.sh".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/hyprland/gamemode.sh";
}
