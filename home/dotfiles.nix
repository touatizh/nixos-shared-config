let
  BASEDIR = /home/helmi/.nixOs-config/home/dotfiles;
in
{
  home.file = {
    ".gitconfig".source = BASEDIR+"/git/.gitconfig";
    ".config/starship.toml".source = BASEDIR+"/starship/starship.toml";
    ".ssh" = {
      source = BASEDIR+"/ssh";
      recursive = true;
    };
    ".config/fish/conf.d/config.fish" = {
      source = BASEDIR+"/fish/config.fish";
      recursive = true;
    };
    ".config/hypr" = {
      source = BASEDIR+"/hypr";
      recursive = true;
    };
    ".config/kitty" = {
      source = BASEDIR+"/kitty";
      recursive = true;
    };
    ".config/wofi" = {
      source = BASEDIR+"/wofi";
      recursive = true;
    };
    ".config/waybar" = {
      source = BASEDIR+"/waybar";
      recursive = true;
    };
    ".config/touchegg" = {
      source = BASEDIR+"/touchegg";
      recursive = true;
    };
  };
}
