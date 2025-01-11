{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
  dotfiles = import ./dotfiles.nix;
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

  # Set environment variables
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "hyprland";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Enable Git and set global configurations
  programs.git = {
    enable = true;
    userEmail = "touatizh@gmail.com";
    userName = "Helmi Touati";
  };

  programs.fish = {
      enable = true;
      plugins = [
        # Enable plugins
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        { name = "z"; src = pkgs.fishPlugins.z.src; }
        { name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
        { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
        { name = "bass"; src = pkgs.fishPlugins.bass.src; }
      ];
    };

  # User-specific packages
  home.packages = with pkgs; [
    glib
    krusader
    nemo
    libreoffice-fresh
    vivaldi
    vlc
    notion-app-enhanced
    remnote
    localsend
    fastfetch
    codeium
    git
    github-desktop
    zed-editor
    discord
    bottles
    nix-your-shell
    starship
    kitty
    waybar
    rofi
    grc
    fzf
    hyprshot
    hyprlock
    hypridle
    hyprpaper
    hyprsunset
    hyprpolkitagent
    dunst
    libnotify
    font-awesome
    wlogout
    playerctl
    libinput
    touchegg
    waycorner
    pipx
    waypaper
    pywal
    bibata-cursors
    papirus-icon-theme
    cliphist
    wl-clipboard
    unstable.ghostty
  ];

  programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; vscExtensions;
    };

  # Import dotfiles
  home.file = dotfiles.home.file;

  # Font config
  fonts.fontconfig.enable = true;
}
