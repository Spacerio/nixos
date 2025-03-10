{config, ...}: {
  imports = [
    ./terminal/fish.nix
  ];

  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
  xdg.configFile.wlogout.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/wlogout";
  xdg.configFile.rofi.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/rofi";
  xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr";
  xdg.configFile.wal.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/wal";
  xdg.configFile.sway.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/sway";
  xdg.configFile.tmux.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/term/tmux";
  xdg.configFile.waybar.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/waybar";
  xdg.configFile.kitty.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/term/kitty";
  home.file.".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.vimrc";
}
