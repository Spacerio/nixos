{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.syncthing = {
    enable = lib.mkEnableOption "syncthing";
  };
  config = lib.mkIf config.my.syncthing.enable {
    # Syncthing
    services.syncthing = {
      enable = true;
      user = "lait";
      group = "users";
      dataDir = "/home/lait";
      openDefaultPorts = true;
    };
  };
}
