{
  pkgs,
  lib,
  config,
  ...
}: {
  options.virtualization = {
  	enabled = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "enable virtualization or not";
    };
  };
  config = lib.mkIf (config.virtualization.enabled) {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    users.groups.libvirtd.members = [ "lait" ];
  };
}
