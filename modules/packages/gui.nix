{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.packages.gui = {
    enable = lib.mkEnableOption "packages.gui";
  };
  config = lib.mkIf config.my.packages.gui.enable {
    environment.systemPackages = with pkgs; [
      firefox
      kitty
      rofi-wayland
      pavucontrol
      libreoffice
      gimp
      zathura
      keepassxc
      bitwarden-desktop
    ];
  };
}
