{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.packages.term = {
    enable = lib.mkEnableOption "packages.term";
  };
  config = lib.mkIf config.my.packages.term.enable {
    environment.systemPackages = with pkgs; [
      pywal
      lazygit
      tmux
      fzf
      fish
      zsh
      # rust 
      ripgrep
      fd
      bat
      eza
      lsd
      dust
      dua
      # nix
      nix-init
      nix-index
      nix-inspect
      nix-fast-build
      # system monitors
      htop
      btop
      spotify-player
      pulsemixer
      bluetui
      bluetuith
    ];
  };
}
