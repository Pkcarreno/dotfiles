set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

if type -q /home/linuxbrew/.linuxbrew/bin/brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    set -Ux HOMEBREW_NO_AUTO_UPDATE 1
end

switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
test -f $LOCAL_CONFIG; and source $LOCAL_CONFIG

if status is-interactive
    set fish_greeting ""

    # theme
    set -g theme_color_scheme terminal-dark
    set -g fish_prompt_pwd_dir_length 1
    set -g theme_display_user no
    set -g theme_hide_hostname yes
    set -g theme_hostname no

    # Fzf
    set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
    set -g FZF_LEGACY_KEYBINDINGS 0

    # aliases
    alias ls "ls -p -G"
    alias la "ls -A"
    alias ll "ls -l"
    alias lla "ll -A"
    alias g git
    command -qv nvim && alias vim nvim

    if type -q eza
        alias ll "eza -l -g --icons"
        alias lla "ll -a"
    end

    if type -q tmux
        alias ide "~/.scripts/ide"
    end
end
