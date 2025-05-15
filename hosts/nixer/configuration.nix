# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../hardware
    ../../modules/os
    ../../modules/services
    ../../modules/packages
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.fira-code
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lait = {
    isNormalUser = true;
    description = "lait";
    extraGroups = ["networkmanager" "wheel" "uinput" "audio"];
    shell = pkgs.bash;
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "lait";

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  # TODO: move this to overlays dir
  # nixpkgs.overlays = [
  #   (final: _prev: {
  #     unstable = import inputs.nixpkgs-unstable {
  #       inherit (final) system config;
  #     };
  #   })
  # ];

  environment.systemPackages = with pkgs; [
    # texlive for latex
    texlive.combined.scheme-medium
    # update with flake update neovim-nightly
    inputs.neovim-nightly.packages.${pkgs.system}.default
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.fish.enable = true;
  programs.zsh.enable = true;

  programs.nh = {
    enable = true;
    flake = "/home/lait/dotfiles/nixos";
  };

  programs.steam.enable = true;

  # bash as a login shell but fish for interactive use
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]] then
       shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
       exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # enable support for flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
