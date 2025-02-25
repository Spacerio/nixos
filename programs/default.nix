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
  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/nvim";
  xdg.configFile.wlogout.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/wlogout";
  xdg.configFile.rofi.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/rofi";
  home.file.".config/wal".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/wal";
}
