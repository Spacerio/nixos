{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my = {
    virtualization.enable = lib.mkEnableOption "virtualization";
  };
  config = lib.mkIf config.my.virtualization.enable {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    users.groups.libvirtd.members = ["lait"];
  };
}
