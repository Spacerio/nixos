{ config, pkgs, ... }:

{ 
   imports = [
     ./programs/sway
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

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
