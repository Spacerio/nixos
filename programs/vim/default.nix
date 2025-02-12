{ config, pkgs, ... }:

{
  home.file.".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/vim/.vimrc";
}
