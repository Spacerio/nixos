{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./grub.nix
    ./udev.nix
    ./nvidia.nix
  ];
  config.my.grub.enable = lib.mkDefault true;
  config.my.udev.enable = lib.mkDefault true;
  config.my.nvidia.enable = lib.mkDefault true;
}
