
CONDA_ALT_PATHS="/opt/homebrew/Caskroom/mambaforge/base/bin"
CONDA_ALT_PATHS="/opt/homebrew/Caskroom/miniforge/base/bin:$CONDA_ALT_PATHS"
CONDA_ALT_PATHS="/usr/local/miniforge/base/bin:$CONDA_ALT_PATHS"
CONDA_ALT_PATHS="/usr/local/mambaforge/base/bin:$CONDA_ALT_PATHS"
CONDA_ALT_PATHS="$HOME/opt/mambaforge/base/bin:$CONDA_ALT_PATHS" 
 
CONDA=$(PATH="$CONDA_ALT_PATHS" which "conda")

__conda_setup="$($CONDA 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    CONDA_BIN=$(dirname $CONDA)/..
    if [ -f "$CONDA_BIN/../base/etc/profile.d/conda.sh" ]; then
        . "$CONDA_BIN/../base/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_BIN:$PATH"
    fi
fi
unset __conda_setup
unset CONDA_ALT_PATHS
unset CONDA
