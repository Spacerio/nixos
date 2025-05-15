{
  config,
  lib,
  pkgs,
  ...
}: {
  options.my = {
    grub.enable = lib.mkEnableOption "grub";
  };
  config = lib.mkIf config.my.grub.enable {
    boot.loader.systemd-boot.enable = false;
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.timeout = null;
    boot.loader.grub.extraEntries = ''
      menuentry "PowerOff" {
        halt
      }
    '';
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
