{ config, pkgs, ... }:

{ 
   imports = [
     ../.././programs
   ];
   home.username = "lait";
   home.homeDirectory = "/home/lait";

   home.packages = with pkgs; [
   ];
  
   programs.git = {
     enable = true;
     userName = "Oiva Laitinen";
     userEmail = "oiva.laitinen2@gmail.com";
   };

  programs.fish = {
    enable = true;
    shellAliases = {
      lg = "lazygit";

    };
  };


  manual.manpages.enable = true;

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
