{
  config,
  lib,
  ...
}: {
  options.my = {
    dotfiles.enable = lib.mkEnableOption "dotfiles";
    dotfiles.path = lib.mkOption {
      type = lib.types.path;
      default = "${config.home.homeDirectory}/dotfiles/";
      description = ''
        dotfiles path as a string
      '';
    };
  };
  config = lib.mkIf config.my.dotfiles.enable {
    xdg.configFile.nvim.source    = config.lib.file.mkOutOfStoreSymlink "${config.my.dotfiles.path}/nvim";
    xdg.configFile.wlogout.source = config.lib.file.mkOutOfStoreSymlink "${config.my.dotfiles.path}/wlogout";
    xdg.configFile.rofi.source    = config.lib.file.mkOutOfStoreSymlink "${config.my.dotfiles.path}/rofi";
    xdg.configFile.hypr.source    = config.lib.file.mkOutOfStoreSymlink "${config.my.dotfiles.path}/hypr";
    xdg.configFile.wal.source     = config.lib.file.mkOutOfStoreSymlink "${config.my.dotfiles.path}/wal";
    xdg.configFile.sway.source    = config.lib.file.mkOutOfStoreSymlink "${config.my.dotfiles.path}/sway";
    xdg.configFile.tmux.source    = config.lib.file.mkOutOfStoreSymlink "${config.my.dotfiles.path}/term/tmux";
    xdg.configFile.waybar.source  = config.lib.file.mkOutOfStoreSymlink "${config.my.dotfiles.path}/waybar";
    xdg.configFile.kitty.source   = config.lib.file.mkOutOfStoreSymlink "${config.my.dotfiles.path}/term/kitty";
    xdg.configFile.ghostty.source = config.lib.file.mkOutOfStoreSymlink "${config.my.dotfiles.path}/term/ghostty";
    home.file.".vimrc".source     = config.lib.file.mkOutOfStoreSymlink "${config.my.dotfiles.path}/.vimrc";
  };
}
