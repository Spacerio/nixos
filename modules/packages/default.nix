{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./base.nix
    ./term.nix
    ./extra.nix
    ./gui.nix
    ./lsp.nix
  ];
  config.my.packages.base.enable  = lib.mkDefault true;
  config.my.packages.term.enable  = lib.mkDefault true;
  config.my.packages.extra.enable = lib.mkDefault true;
  config.my.packages.gui.enable   = lib.mkDefault true;
  config.my.packages.lsp.enable   = lib.mkDefault true;
}
