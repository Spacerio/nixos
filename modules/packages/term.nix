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
      yazi
      broot
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
    programs = {
      direnv = {
        enable = true;
        silent = true;
        nix-direnv.enable = true;
      };
      zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };
}
