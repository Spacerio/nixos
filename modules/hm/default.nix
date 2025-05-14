{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./fish.nix
    ./dotfiles.nix
  ];
  config.my.fish.enable = lib.mkDefault true;
  config.my.dotfiles.enable = lib.mkDefault true;
}
