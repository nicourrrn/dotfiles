# ai <проєкт> <роль> [claude|agy] — arch-custom-os/bin/ai
complete -c ai -f
complete -c ai -n 'test (count (commandline -opc)) -eq 1' -a '(zoxide query -l | string replace -r ".*/" "" | sort -u)' -d проєкт
complete -c ai -n 'test (count (commandline -opc)) -eq 2' -a '(path basename -E ~/.config/ai/roles/*.md)' -d роль
complete -c ai -n 'test (count (commandline -opc)) -eq 3' -a 'claude agy' -d агент
