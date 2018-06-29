# Source .bashrc for aliases and functions
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Exports
export TERM="xterm-256color"

# Better prompts [user@hostname:<directory> (git branch)]
PS1="\[\e[0m\][\[\e[32m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]:\[\e[35m\]\w\[\e[0;31m\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2 | xargs -I{} echo ' ({})')\[\e[0m\]]\\$ "

# Source .bashrc_work
if [ -f ~/.bashrc_work ]; then
    source ~/.bashrc_work
fi

# Source .bash_profile_work
if [ -f ~/.bash_profile_work ]; then
    source ~/.bash_profile_work
fi
