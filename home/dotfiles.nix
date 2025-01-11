let
  BASEDIR = ./dotfiles;
in
{
  home.file = {
    ".config" = {
      source = BASEDIR;
      recursive = true;
    };
    ".gitconfig".source = BASEDIR+"/git/.gitconfig";
  };
}
