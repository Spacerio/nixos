{ config, ... }:

{

  home.file.".config/waybar/config".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/waybar/config";
  home.file.".config/waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/waybar/style.css";

}
