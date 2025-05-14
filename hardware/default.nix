{ config, lib, pkgs, ... }: {
  imports = [
    ./grub.nix
    ./udev.nix
  ];
  config.my.grub.enable = lib.mkDefault true;
  config.my.udev.enable = lib.mkDefault true;
}
