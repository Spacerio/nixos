{ config, lib, ... }: {

  home.file.".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/kitty/kitty.conf";
}
