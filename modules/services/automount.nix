{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.automount = {
    enable = lib.mkEnableOption "automount";
  };
  config = lib.mkIf config.my.automount.enable {
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };
}
