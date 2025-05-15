{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.hyprland = {
    enable = lib.mkEnableOption "hyprland";
    autostart = lib.mkEnableOption "hyprland autostart";
  };
  config = lib.mkIf config.my.hyprland.enable {
    programs.hyprland = {
      enable = true;
    };
    environment.systemPackages = with pkgs; [
      waybar
      pyprland
      hyprpaper
      hyprlock
      wlogout
      swww
      grim
      slurp
    ];
    # autostart Hyprland
    # TODO: figure out a less hacky way to do this
    environment.loginShellInit = lib.mkIf config.my.hyprland.enable ''
      [[ "$(tty)" == /dev/tty1 ]] && exec Hyprland
    '';
  };
}
