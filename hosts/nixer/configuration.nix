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
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
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

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixer"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


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
    gcc
    git
    wget
    gnumake
    lazygit
    firefox
	unstable.librewolf
	unstable.floorp
    wezterm
    kitty
    kanata
    htop
    btop

    rofi-wayland
    wofi
    unstable.tofi
    waybar
    pywal
    wlogout
    hyprpaper
    hyprlock
    swww
    grim
    slurp

    pavucontrol
    lxqt.pavucontrol-qt
    easyeffects
    pulsemixer
    sink-rotate
    bluetuith

    ncspot
    cava

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
    flake = "/home/lait/nixos";
  };

  xdg.portal = {
	enable = true;
	extraPortals = [pkgs.xdg-desktop-portal-gtk];
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

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]] then
       shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
       exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # TODO: needs to be cloned before making symlinks etc.
  # possibly need to use home.activation or similar
  systemd.services.dofiles = {
	enable = true;
	wantedBy = ["multi-user.target"];
	serviceConfig = {
	  ExecStart = "${pkgs.writeShellScript "watch-store" ''
		  #!/usr/bin/env bash
		  if [ ! -d /home/lait/dotfiles ]; then
			echo "Cloning dotfiles into ~/dotfiles"
			${pkgs.git}/bin/git clone https://github.com/spacerio/.dotfiles.git /home/lait/dotfiles
			chown -R lait /home/lait/dotfiles
		  else
			echo "Not cloning dotfiles"
		  fi
		''}";
	};
  };

  # programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  # ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.variables = {
    EDITOR = "vim";
    SUDO_EDITOR = "vim";
    VISUAL = "vim";
    TERM = "xterm";
  };

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && exec Hyprland
  '';

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking = {
	networkmanager.enable = true;
	# # not working, need to figure out atleast subnets
	# dhcpcd.enable = false;
	# enableIPv6 = false;
	# nameservers = [ "8.8.8.8" "0.0.0.0" ];
	# interfaces.enp4s0 = {
	#   ipv4.addresses = [{
	# 	address = "91.154.72.10";
	# 	prefixLength = 24;
	#   }];
	# };
	# defaultGateway = {
	#   address = "192.0.2.1";
	#   interface = "enp4s0";
	# };
  };

	#  systemd.network.enable = true;
	#  systemd.network.networks."enp4s0" = {
	# matchConfig.Name = "lan";
	# networkConfig = {
	# };
	#  };

  #enable audio through pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # hardware.pulseaudio.enable = true;
  # nixpkgs.config.pulseaudio = true;
  # hardware.pulseaudio.extraConfig = "load-module module-combine-sink";
  # services.pipewire.enable = false;

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
