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

    # Auto-start Zellij by default
    if not set -q ZELLIJ; and test "$TERM" != "dumb"; and not set -q NVIM; and test "$TERM_PROGRAM" != "vscode"; and not set -q NO_ZELLIJ
        exec zellij
    end

    starship init fish | source
    zoxide init fish | source
    mise activate fish | source

    if not set -q SHLVL; or test "$SHLVL" -eq 1
        pokemon-colorscripts -r -s --no-title | fastfetch --file-raw -
    end
end

# >>> lean-ctx wrap claude >>>
set -gx ANTHROPIC_BASE_URL "http://127.0.0.1:4444"
# <<< lean-ctx wrap claude <<<
