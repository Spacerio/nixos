{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.packages.base = {
    enable = lib.mkEnableOption "packages.base";
  };
  config = lib.mkIf config.my.packages.base.enable {
    environment.systemPackages = with pkgs; [
      coreutils
      libtool
      gcc
      git
      vim
      helix
      emacs
      gnumake
      pywal
      lazygit
      tmux
      fzf
      zsh
    ];
    programs.fish.enable = true;
  };
}
