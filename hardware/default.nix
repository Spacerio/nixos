{ config, lib, pkgs, ... }: {
  imports = [
    ./grub.nix
  ];
  config.grub.enable = lib.mkDefault true;
}
