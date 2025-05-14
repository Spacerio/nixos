{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.kanata = {
    enable = lib.mkEnableOption "kanata";
  };
  config = lib.mkIf config.my.kanata.enable {
    hardware.uinput.enable = true;
    services.kanata = {
      enable = true;
      keyboards = {
        "logi".config = ''
          (defsrc
            caps
          )
          (deflayer base
            esc
          )
        '';
      };
    };
  };
}
