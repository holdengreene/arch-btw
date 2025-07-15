if status is-interactive
    # Commands to run in interactive sessions can go here
end

if type -q starship
starship init fish | source
end

if type -q bat
set -x PAGER bat
end

if type -q nvim
alias v="nvim"
end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
