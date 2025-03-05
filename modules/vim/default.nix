{
  config,
  pkgs,
  ...
}: {
  home.file.".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nixos/modules/vim/.vimrc";
}
