{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./git.nix
    ./kanata.nix
  ];

  # Bootloader
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    loader.grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      timeoutStyle = "hidden";
    };
    plymouth.enable = true;
  };

  # Kernel
  boot.kernel.sysctl = {
    "vm.swappiness" = 4;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "acpi_osi=\"!Windows 2015\""
  ];
  boot.blacklistedKernelModules = [
    "uvcvideo"
    "nouveau"
  ];
  boot.consoleLogLevel = 0;

  # Language
  services.chrony.enable = true;
  services.automatic-timezoned.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "no";
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

  # Networking
  networking.hostName = username;
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      1420 # Tauri
      5078 # Brainy-Backend
    ];
  };

  # Other
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "uinput"
      "docker"
      "kvm"
    ];
    packages = [ ];
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Packages
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    (brave.override {
      commandLineArgs = [
        "--enable-features=TouchpadOverscrollHistoryNavigation"
      ];
    })
    fastfetch
    htop
    kitty
    lshw
    pciutils
    ripgrep
    tldr
    unzip
    vimPlugins.nvim-treesitter.withAllGrammars
    wget
    wl-clipboard
    zsh-powerlevel10k
  ];
  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    nerd-fonts.hack
  ];
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs.partition-manager.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Hyprland
  programs.hyprland.enable = true;
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    extraPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
    theme = "${
      pkgs.sddm-astronaut.override {
        themeConfig = {
          FullBlur = true;
          BlurMax = 64;
          Blur = 1.0;
          DimBackground = 0.2;
        };
      }
    }/share/sddm/themes/sddm-astronaut-theme";
  };

  # Other settings
  services.cron.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.logitech.wireless.enable = true;
  virtualisation.docker.enable = true;

  # Environment variables
  environment.sessionVariables = {
    QT_SCALE_FACTOR = 1;
    GTK_USE_PORTAL = 1;
    NIXOS_OZONE_WL = 1;
  };

  # Printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    socketActivation = true;
  };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "9:00" ];

  # Auto system update
  system.autoUpgrade = {
    enable = true;
  };

  # Laptops
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";

    HandlePowerKey = "suspend";
  };

  # Keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Don't keep old builds to save storage
  nix.settings.keep-failed = false;
  nix.settings.keep-going = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
