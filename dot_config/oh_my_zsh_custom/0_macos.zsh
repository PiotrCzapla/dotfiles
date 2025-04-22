



# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code -w -n'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias spawn-gpu="op run -- conda run -n spawn-gpu python -m spawn_gpu"
alias nbdev_release_gh='op run -- nbdev_release_gh' 

function wait_for_ssh () {
  while ! ssh $1 echo "V" 2>/dev/null; do echo -n .;sleep 1; done
  echo connected
}

function galatea_unlock () {
  wait_for_ssh galatea.unlock
  op read -n op://_scripts/galatea.unlock/password | ssh galatea.unlock cryptroot-unlock; 
}
function galatea_open() {
  wait_for_ssh galatea
  ssh galatea
}

alias galatea_sync='rsync -av ~/WorkDL/part2/ galatea:~/workspace/part2/'
alias talos_sync='rsync -av ~/WorkDL/part2/ wsl.talos:~/workspace/part2/'
alias sd_sync='rsync -av ~/WorkDL/part2/ sd:~/'
function mkcert() {
    MKCERT_CMD=$(which -p mkcert 2>/dev/null || which mkcert)
    [ -x "$MKCERT_CMD" ] || { echo "Error: mkcert not found in PATH." >&2; return 1; }
    DEFAULT_CAROOT=$("$MKCERT_CMD" --CAROOT)
    TEMP_CAROOT=$(mktemp -d /tmp/mkcert_caroot.XXXXXX)
    # trap to clean up the temp dir at the exit
    trap "rm -rf \"$TEMP_CAROOT\"" EXIT
    cp "$DEFAULT_CAROOT/rootCA.pem" "$TEMP_CAROOT/" || { echo "Error: Failed to copy rootCA.pem." >&2; return 1; }
    op read -o "$TEMP_CAROOT/rootCA-key.pem" -f -n "op://Personal/mkcert/rootCA-key.pem" >/dev/null || { echo "Error: Failed to retrieve rootCA-key.pem from 1Password." >&2; return 1; }
    chmod 600 "$TEMP_CAROOT/rootCA-key.pem"

    CAROOT="$TEMP_CAROOT" "$MKCERT_CMD" "$@"
}

alias jb_verrucosum='/Applications/Vivaldi.app/Contents/MacOS/Vivaldi --profile-directory='verrucosum' --host-resolver-rules="MAP www.jungleboogie.pl 65.108.76.42"'

PROMPT="%{$fg[cyan]%}$HOST_SHORT ${PROMPT}"
alias talos_start='(sleep 5; open http://localhost:8899) & ssh wsl.talos -L 8899:localhost:8888 -t ./start.sh'

if [ -d "$HOME/.modular" ]; then
  if [ -f "$HOME/.modular/bin/magic" ]; then
    export PATH="$PATH:$HOME/.modular/bin"
    eval "$(magic completion --shell zsh)"
  fi
fi
if [ -d "$HOME/.pixi" ]; then
  if [ -f "$HOME/.pixi/bin/pixi" ]; then
    export PATH="$PATH:$HOME/.pixi/bin"
    eval "$(pixi completion --shell zsh)"
  fi
fi

# not let see if .docker exists
if [ -d "$HOME/.docker" ]; then
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
fi


alias code=code-insiders
alias devcontainer=devcontainer-insiders