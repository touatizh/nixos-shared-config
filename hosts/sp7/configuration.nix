{ config, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/microsoft/surface/surface-pro-intel>
      ./hardware-configuration.nix
      ../backup_strat.nix
      ../nftables.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "sp7";

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

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  services.xserver.xkb = {
    layout = "fr";
    variant = "nodeadkeys";
  };

  console.keyMap = "fr";

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

  users.users.helmi = {
    isNormalUser = true;
    description = "Helmi";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  environment.systemPackages = with pkgs; [
    neovim
    surface-control
    iptsd
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
    libvirt
    gnumake
    libudev-zero
    qt5.qtbase
    qt5.qtwayland
    xorg.libxcb
    libxkbcommon
    home-manager
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-wlr
  ];

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
  services.iptsd.enable = true;
  services.touchegg.enable = true;

  system.stateVersion = "24.11";
}
