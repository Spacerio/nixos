{ config, lib, pkgs, ... }: {
  imports = [
    ./grub.nix
  ];
  config.my.grub.enable = lib.mkDefault true;
}
