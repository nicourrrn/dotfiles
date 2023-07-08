#!/usr/bin/env zsh

source /usr/share/zsh/scripts/zplug/init.zsh

HISTFILE=$HOME/.config/zsh/.zsh_history

zplug "themes/eastwood", as:theme, from:oh-my-zsh

zplug "plugins/z", from:oh-my-zsh
zplug "plugins/copydir", from:oh-my-zsh
zplug "plugins/copybuffer", from:oh-my-zsh
zplug "plugins/dirhistory", from:oh-my-zsh
zplug "plugins/jsontools", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/archlinux", from:oh-my-zsh
zplug "plugins/autopep8", from:oh-my-zsh
zplug "plugins/deno", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/emoji", from:oh-my-zsh
zplug "plugins/emotty", from:oh-my-zsh
zplug "plugins/encode64", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/fancy-ctrl-z", from:oh-my-zsh
zplug "plugins/fasd", from:oh-my-zsh
zplug "plugins/fd", from:oh-my-zsh
zplug "plugins/flutter", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/gitfast", from:oh-my-zsh
zplug "plugins/git-hubflow", from:oh-my-zsh
zplug "plugins/gitignore", from:oh-my-zsh
zplug "plugins/git-prompt", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh
zplug "plugins/nmap", from:oh-my-zsh
zplug "plugins/pep8", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/poetry", from:oh-my-zsh
zplug "plugins/postgres", from:oh-my-zsh
zplug "plugins/pylint", from:oh-my-zsh
zplug "plugins/redis-cli", from:oh-my-zsh
zplug "plugins/rand-quote", from:oh-my-zsh
zplug "plugins/ripgrep", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/yarn", from:oh-my-zsh
zplug "plugins/themes", from:oh-my-zsh
zplug "plugins/thefuck", from:oh-my-zsh


zplug "wting/autojump"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "StackExchange/blackbox"
zplug "bobthecow/git-flow-completion"
zplug "zsh-users/zsh-completions"
zplug "fcambus/ansiweather"
zplug "rimraf/k"
zplug "b4b4r07/enhancd"
zplug "sobolevn/git-secret"
zplug "so-fancy/diff-so-fancy"
zplug "jonas/tig"

zplug load

GTK_THEME=Gruvbox-Material-Dark

alias ls="lsd"
alias df="df -h"
alias battery="bat /sys/class/power_supply/BAT1/capacity"

