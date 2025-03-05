{config, ...}: {
  home.file.".config/sway/config".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nixos/modules/sway/config";
}
