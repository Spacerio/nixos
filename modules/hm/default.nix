{ config, pkgs, lib, ... }: {
  options = {
    enableFish = lib.mkOption {
    };
  };
  imports = [
    ./fish.nix
    ./symlinks.nix
  ];
}
