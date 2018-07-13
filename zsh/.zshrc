source ~/.zplug/init.zsh

zplug "lib/completion", from:oh-my-zsh
zplug "mafredri/zsh-async", from:github, defer:0
zplug "modules/git", from:prezto
zplug "modules/prompt", from:prezto
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/virtualenvwrapper", from:oh-my-zsh
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
zplug "chrissicool/zsh-256color", use:zsh-256color.plugin.zsh, defer:3

setopt prompt_subst
zplug "caiogondim/bullet-train.zsh", use:bullet-train.zsh-theme, defer:3

zplug load

# Enable ctrl+r search
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# Themeing
export BULLETTRAIN_PROMPT_ORDER=(time context dir virtualenv git cmd_exec_time)

# Other Things
export PATH="~/.bin:${PATH}"
export EDITOR="nvim"
