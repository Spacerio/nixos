{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./virtualization.nix
    ./networking.nix
    ./localization.nix
    ./spicetify.nix
    ./environment.nix
    ./hyprland.nix
  ];
  config.my.virtualization.enable = lib.mkDefault true;
  config.my.networking.enable = lib.mkDefault true;
  config.my.localization.enable = lib.mkDefault true;
  config.my.spicetify.enable = lib.mkDefault true;
  config.my.environment.enable = lib.mkDefault true;
  config.my.hyprland.enable = lib.mkDefault true;
  config.my.hyprland.autostart = lib.mkDefault true;
}
