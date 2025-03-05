{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../.././programs
  ];
  home.username = "lait";
  home.homeDirectory = "/home/lait";

  home.packages = with pkgs; [
    nil
    bash-language-server
    lua-language-server
    alejandra

    unstable.yazi
    broot
    dust
  ];

  programs.gh.enable = true;
  programs.git = {
    enable = true;
    userName = "Oiva Laitinen";
    userEmail = "oiva.laitinen2@gmail.com";
    extraConfig = {
      credential.helper = "oauth";
    };
  };

  programs.ghostty.enable = true;

  programs.helix.enable = true;

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
