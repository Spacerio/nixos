{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.environment = {
    enable = lib.mkEnableOption "environment";
  };
  config = lib.mkIf config.my.environment.enable {
    environment.sessionVariables = {
      # hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
      # flake for nh, not working
      FLAKE = "/home/lait/dotfiles/nixos";
    };

    environment.variables = {
      EDITOR = "vim";
      SUDO_EDITOR = "vim";
      VISUAL = "vim";
      TERM = "xterm";
    };

    # autostart Hyprland
    # TODO: figure out a less hacky way to do this
    environment.loginShellInit = ''
      [[ "$(tty)" == /dev/tty1 ]] && exec Hyprland
    '';
  };
}
