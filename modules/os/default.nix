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
  ];
  config.my.virtualization.enable = true;
  config.my.networking.enable = true;
  config.my.localization.enable = true;
}
