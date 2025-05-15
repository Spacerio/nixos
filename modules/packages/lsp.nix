{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.packages.lsp = {
    enable = lib.mkEnableOption "packages.lsp";
  };
  config = lib.mkIf config.my.packages.lsp.enable {
    environment.systemPackages = with pkgs; [
    ];
  };
}
