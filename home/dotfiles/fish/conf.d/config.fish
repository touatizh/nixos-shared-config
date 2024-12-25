# Greeting
function fish_greeting -d "What's up, fish?"
    set_color $fish_color_autosuggestion
    uname -nmsr

    command -q uptime
    and command uptime

    set_color normal
end

### Custom Prompts ###
# Starship
starship init fish | source

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
function rown --argument index
    sed -n "$index p"
end


### nix-your-shell ###
if command -q nix-your-shell
  nix-your-shell fish | source
end

### Aliases ###
# Power
alias reboot='sudo shutdown -r now'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias lsa='ls -al'
alias symlink='ln -s'

# nix and nixOS
alias auf='export NIXPKGS_ALLOW_UNFREE=1'
alias spswall='sudo nixos-rebuild switch --flake .#sp --impure && home-manager switch --flake .#home --impure'
alias gigaswall='sudo nixos-rebuild switch --flake .#gigaos && home-manager switch --flake .#home --impure'
alias homesw='home-manager switch --flake .#home --impure'

# adding flags
alias grep='grep --color=auto'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

#git
alias gstat='git status'
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push -u origin main'
alias tag='git tag'
alias newtag='git tag -a'
