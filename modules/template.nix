{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.xxx = {
    enable = lib.mkEnableOption "xxx";
  };
  config = lib.mkIf config.my.xxx.enable {

  };
}
