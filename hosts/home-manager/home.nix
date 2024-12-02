{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";
  home.username = "helmi";
  home.homeDirectory = "/home/helmi";

  # Enable Git and set global configurations
  programs.git = {
    enable = true;
    userEmail = "touatizh@gmail.com";
    userName = "Helmi Touati";
  };

  # User-specific packages
  home.packages = with pkgs; [
    neovim
    onlyoffice-bin
    libreoffice-qt6-fresh
    brave
    vlc
    notion-app-enhanced
    remnote
    localsend
    fastfetch
    vscodium
    git
    github-desktop
    (import <nixos-unstable> {}).zed-editor
  ];
}
