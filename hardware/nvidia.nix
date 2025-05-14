{
  pkgs,
  lib,
  config,
  ...
}: {
  # configure udev rules for qmk flashing
  options.my.nvidia = {
    enable = lib.mkEnableOption "nvidia";
  };
  config = lib.mkIf config.my.nvidia.enable {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      open = true;
    };
  };
}
