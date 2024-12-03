{ config, pkgs, ... }:

let
  vscExtensions = with pkgs.vscode-extensions; [
    aaron-bond.better-comments
    adpyke.codesnap
    alefragnani.bookmarks
    charliermarsh.ruff
    christian-kohler.path-intellisense
    dbaeumer.vscode-eslint
    eamodio.gitlens
    equinusocio.vsc-material-theme
    equinusocio.vsc-material-theme-icons
    esbenp.prettier-vscode
    formulahendry.auto-rename-tag
    formulahendry.code-runner
    github.vscode-github-actions
    gruntfuggly.todo-tree
    humao.rest-client
    johnpapa.vscode-peacock
    mechatroner.rainbow-csv
    mhutchie.git-graph
    ms-dotnettools.vscode-dotnet-runtime
    ms-python.debugpy
    ms-python.python
    ms-toolsai.jupyter
    ms-toolsai.jupyter-keymap
    ms-toolsai.jupyter-renderers
    ms-toolsai.vscode-jupyter-cell-tags
    ms-toolsai.vscode-jupyter-slideshow
    ms-vsliveshare.vsliveshare
    ms-dotnettools.csharp
    njpwerner.autodocstring
    oderwat.indent-rainbow
    pkief.material-icon-theme
    ritwickdey.liveserver
    streetsidesoftware.code-spell-checker
    tamasfe.even-better-toml
    usernamehw.errorlens
    visualstudioexptteam.vscodeintellicode
    yzane.markdown-pdf
    yzhang.markdown-all-in-one
  ];

in

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
    codeium
    git
    github-desktop
    zed-editor
  ];

  programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; vscExtensions;
    };
}
