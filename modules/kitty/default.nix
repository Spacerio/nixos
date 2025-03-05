{
  config,
  lib,
  ...
}: {
  home.file.".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nixos/modules/kitty/kitty.conf";
}
