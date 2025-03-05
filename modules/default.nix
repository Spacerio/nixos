{config, ...}: {
  imports = [
    ./sway
    ./vim
    ./hyprland
    ./waybar
    ./tmux
    ./terminal/fish.nix
    ./kitty
  ];

  # copy nvim directory to .config/nvim
  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
  xdg.configFile.wlogout.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nixos/modules/wlogout";
  xdg.configFile.rofi.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nixos/modules/rofi";
  home.file.".config/wal".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nixos/modules/wal";
}
