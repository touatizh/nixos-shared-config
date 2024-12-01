{ config, pkgs, ... }:

{
  home.username = "helmi";
  home.homeDirectory = "/home/helmi";

  # Enable ZSH with plugins and themes
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "z" "history" "extract" ];
    };
  };

  # Enable Git and set global configurations
  programs.git = {
    enable = true;
    userEmail = "touatizh@gmail.com";
    userName = "Helmi Touati";
    extraConfig = {
      "alias.st" = "status";
    };
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
