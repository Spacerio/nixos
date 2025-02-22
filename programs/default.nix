{config, ...}: {
  imports = [
    ./sway
    ./vim
    ./hyprland
    ./waybar
    ./tmux
  ];

  # copy nvim directory to .config/nvim
  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/programs/nvim";
}
