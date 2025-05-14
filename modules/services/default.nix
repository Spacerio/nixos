{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./automount.nix
    ./syncthing.nix
    ./kanata.nix
  ];
  config.my.audio.enable = lib.mkDefault true;
  config.my.bluetooth.enable = lib.mkDefault true;
  config.my.automount.enable = lib.mkDefault true;
  config.my.syncthing.enable = lib.mkDefault true;
  config.my.kanata.enable = lib.mkDefault true;
}
