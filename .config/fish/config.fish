set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

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

    set -l active_theme kanagawa-dragon
    set -l theme_path ~/.config/fish/themes/$active_theme.fish
    test -r $theme_path; and source $theme_path

    if type -q eza
        set fzf_preview_dir_cmd eza --all --color=always
    end

    if type -q bat
        set fzf_preview_file_cmd "bat --style=numbers --color=always --line-range :500"
    end

    if type -q delta
        set fzf_diff_highlighter delta --paging=never --width=20
    end
end
