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
	fzf

	ripgrep
	unstable.yazi
	broot
	dust
  ];

  programs.git = {
    enable = true;
    userName = "Oiva Laitinen";
    userEmail = "oiva.laitinen2@gmail.com";
  };

  programs.ghostty.enable = true;

  programs.helix.enable = true;

  manual.manpages.enable = true;

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
