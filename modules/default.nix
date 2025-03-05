{config, ...}: {
  imports = [
    ./sway
    ./vim
    ./waybar
    ./tmux
    ./terminal/fish.nix
    ./kitty
  ];

  # copy nvim directory to .config/nvim
  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
  xdg.configFile.wlogout.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/wlogout";
  xdg.configFile.rofi.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/rofi";
  xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr";
  xdg.configFile.wal.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/wal";
}
