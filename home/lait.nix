{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules
    ../modules/terminal/fish.nix
  ];
  home.username = "lait";
  home.homeDirectory = "/home/lait";

  home.packages = with pkgs; [
    nil
    nixd
    bash-language-server
    lua-language-server
    csharp-ls
    clang-tools
    gdb
    alejandra

    unstable.yazi
    broot

    direnv
    nix-direnv

    ispell
    wordnet
  ];

  programs.gh.enable = true;
  programs.git = {
    enable = true;
    userName = "Oiva Laitinen";
    userEmail = "oiva.laitinen2@gmail.com";
    # extraConfig = {
    #   credential.helper = "oauth";
    # };
  };

  programs.ghostty.enable = true;

  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.unstable.emacs;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Grey-Dark";
    };
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-blue-dark";
    };
  };

  manual.manpages.enable = true;

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
