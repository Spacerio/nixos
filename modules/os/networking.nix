{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.networking = {
    enable = lib.mkEnableOption "networking";
    hostName = lib.mkOption {
      type = lib.types.string;
      default = "nixer";
    };
  };
  config = lib.mkIf config.my.networking.enable {
    # setup networking
    networking = {
      hostName = config.my.networking.hostName;
      # Setting an static ip doesn't work when not connected via a router
      # Because the isp will change the allocated ip regularly
      # Windows prefers direct connection, using networkmanager as dhcpcd is slow
      # defaultGateway = {
      #   address = "91.154.72.1";
      #   interface = "enp4s0";
      # };
      # interfaces.enp4s0 = {
      #   ipv4.addresses = [{
      #     address = "91.154.72.111";
      #     prefixLength = 23;
      #   }];
      # };
      networkmanager.enable = true;
      dhcpcd.enable = false;
      enableIPv6 = true;
      nameservers = ["8.8.8.8" "0.0.0.0"];
    };
  };
}
