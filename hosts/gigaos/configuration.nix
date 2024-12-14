{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./backup_strat.nix
      ../nftables.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.useOSProber = true;

  networking.hostName = "gigaos";

  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Tunis";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_TN.UTF-8";
    LC_IDENTIFICATION = "ar_TN.UTF-8";
    LC_MEASUREMENT = "ar_TN.UTF-8";
    LC_MONETARY = "ar_TN.UTF-8";
    LC_NAME = "ar_TN.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "ar_TN.UTF-8";
    LC_TELEPHONE = "ar_TN.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = false;

  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "es";
    variant = "nodeadkeys";
  };

  console.keyMap = "es";

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  hardware.tuxedo-rs = {
    enable = true;
    tailor-gui.enable = true;
  };

  users.users.helmi = {
    isNormalUser = true;
    description = "Helmi";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  h

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  environment.systemPackages = with pkgs; [
    btop
    tlp
    thermald
    btrbk
    ntfs3g
    borgbackup
    gparted
    wget
    gcc
    libgcc
    gnumake
    libudev-zero
    qt5.qtbase
    qt5.qtwayland
    xorg.libxcb
    libxkbcommon
    home-manager
    xdg-desktop-portal-hyprland
  ];

  programs.hyprland.enable = true;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  networking.firewall.enable = true;
  services.thermald.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
