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
    ../../modules/virtualization.nix
    ../../modules/udev.nix
    inputs.spicetify-nix.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.timeout = null;
  boot.loader.grub.extraEntries = ''
    menuentry "PowerOff" {
      halt
    }
  '';
  boot.loader.efi.canTouchEfiVariables = true;

  # setup networking
  networking = {
    hostName = "nixer";
    # Setting an static ip doesn't work when not connected via a router
    # Windows prefers direct connection, using networkmanager as dhcpcd is slow
    # defaultGateway = {
    #   address = "91.154.72.1";
    #   interface = "enp4s0";
    # };
    # interfaces.enp4s0 = {
    #   ipv4.addresses = [{
    #     address = "91.154.72.111";
    #     prefixLength = 23;
    #   }];
    # };
    networkmanager.enable = true;
    dhcpcd.enable = false;
    enableIPv6 = true;
    nameservers = ["8.8.8.8" "0.0.0.0"];
  };

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };

  fonts.packages = with pkgs.unstable; [
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

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "lait";
    group = "users";
    dataDir = "/home/lait";
    openDefaultPorts = true;
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    (final: _prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (final) system config;
      };
    })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    coreutils
    libtool
    gcc
    git
    wget
    gnumake
    cmake
    unstable.lazygit
    gitui
    firefox
    qutebrowser
    unstable.librewolf
    unstable.floorp
    jetbrains.rider
    wezterm
    kitty
    tmux
    kanata

    htop
    btop
    bottom
    fzf
    ripgrep
    fd
    bat
    eza
    lsd
    dust
    nix-init
    nix-index
    nix-inspect

    rofi-wayland
    wofi
    unstable.tofi
    waybar
    pywal
    pyprland
    hyprpaper
    hyprlock
    wlogout
    swww
    grim
    slurp

    pavucontrol
    easyeffects
    pulsemixer
    bluetui
    bluetuith

    ncspot
    spotify-player
    cava

    # texlive for latex
    texlive.combined.scheme-medium
    # update with flake update neovim-nightly
    inputs.neovim-nightly.packages.${pkgs.system}.default
  ];

  programs.vim.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
  };

  programs.fish.enable = true;
  programs.zsh.enable = true;

  programs.nh = {
    enable = true;
    flake = "/home/lait/dotfiles/nixos";
  };

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    # theme = spicePkgs.themes.text;
    # colorScheme = "CatppuccinMocha";
    theme = spicePkgs.themes.bloom;
    colorScheme = "Dark";

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

  environment.sessionVariables = {
    # hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # flake for nh, not working
    FLAKE = "/home/lait/dotfiles/nixos";
  };

  environment.variables = {
    EDITOR = "vim";
    SUDO_EDITOR = "vim";
    VISUAL = "vim";
    TERM = "xterm";
  };

  # autostart Hyprland
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && exec Hyprland
  '';

  # enable support for flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # automounting services for qmk development
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # enable audio through pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.uinput.enable = true;
  services.kanata = {
    enable = true;
    keyboards = {
      "logi".config = ''
        (defsrc
          caps
        )

        (deflayer base
          esc
        )
      '';
    };
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    open = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
