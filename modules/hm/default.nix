{ config, pkgs, lib, ... }: {
  imports = [
    ./fish.nix
    ./dotfiles.nix
  ];
  config.fish.enable = lib.mkDefault true;
  config.dotfiles.enable = lib.mkDefault true;
}
