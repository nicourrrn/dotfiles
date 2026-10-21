set -gx GOPATH "$HOME/.go"
set -gx XDG_OPEN_HELPER handlr
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

alias xdg-open='handlr open'
alias cd="z"
alias ls="lsd"
alias tree="ls --tree"
alias workstation="ssh nicourrrn@ssh.workstation"
alias home="ssh nicourrrn@ssh.home"

if status is-interactive
    set -g fish_greeting ""

    starship init fish | source
    zoxide init fish | source
    mise activate fish | source

    if not set -q SHLVL; or test "$SHLVL" -eq 1
        pokemon-colorscripts -r -s --no-title | fastfetch --file-raw -
    end
end
