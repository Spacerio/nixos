{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./virtualization.nix
    ./networking.nix
  ];
  config.my.virtualization.enable = true;
  config.my.networking.enable = true;
}
