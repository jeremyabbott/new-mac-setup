source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle lukechilds/zsh-nvm

antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

if [ -d "$HOME/.dotnet" ] ; then
    export PATH="$PATH:$HOME/.dotnet"
fi

if [ -d "$HOME/.dotnet/tools" ] ; then
    export PATH="$PATH:$HOME/.dotnet/tools"
fi