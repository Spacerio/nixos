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
  ];
  config.my.virtualization.enable = true;
  config.my.networking.enable = true;
  config.my.localization.enable = true;
  config.my.spicetify.enable = lib.mkDefault true;
}
