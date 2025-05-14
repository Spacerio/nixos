{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
  };
  config = lib.mkIf config.my.bluetooth.enable {
    # bluetooth
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
  };
}
