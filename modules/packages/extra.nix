{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.packages.extra = {
    enable = lib.mkEnableOption "packages.extra";
  };
  config = lib.mkIf config.my.packages.extra.enable {
    environment.systemPackages = with pkgs; [
      cmake
      qutebrowser
      librewolf
      floorp
      gitui
      wezterm
      bottom
      wofi
      tofi
      ncspot
      cava
      easyeffects
      ispell
      wordnet
    ];
  };
}
