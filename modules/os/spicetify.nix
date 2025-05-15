{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # TODO: move to home-manager configuration
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];
  options.my.spicetify = {
    enable = lib.mkEnableOption "spicetify";
  };
  config = lib.mkIf config.my.spicetify.enable {
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      theme = spicePkgs.themes.text;
      colorScheme = "CatppuccinMocha";
      # theme = spicePkgs.themes.bloom;
      # colorScheme = "Dark";

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
        fullAppDisplayMod
        keyboardShortcut
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
      ];
      enabledSnippets = with spicePkgs.snippets; [
        rotatingCoverart
        pointer
      ];
    };
  };
}
