



# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


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

alias jb_hoya='/Applications/Vivaldi.app/Contents/MacOS/Vivaldi --profile-directory='verrucosum' --host-resolver-rules="MAP www.jungleboogie.pl 100.112.9.92"'

alias talos_start='(sleep 5; open http://localhost:8899) & ssh wsl.talos -L 8899:localhost:8888 -t ./start.sh'

if [ -d "$HOME/.modular" ]; then
  if [ -f "$HOME/.modular/bin/magic" ]; then
    export PATH="$PATH:$HOME/.modular/bin"
    # Lazy load magic completion
    magic() {
      unfunction magic
      eval "$(command magic completion --shell zsh)"
      magic "$@"
    }
  fi
fi
if [ -d "$HOME/.pixi" ]; then
  if [ -f "$HOME/.pixi/bin/pixi" ]; then
    export PATH="$PATH:$HOME/.pixi/bin"
    # Lazy load pixi completion
    pixi() {
      unfunction pixi
      eval "$(command pixi completion --shell zsh)"
      pixi "$@"
    }
  fi
fi

# not let see if .docker exists
if [ -d "$HOME/.docker" ]; then
# Docker CLI completions - just add to fpath, compinit already called in .zshrc
fpath=($HOME/.docker/completions $fpath)
fi

export EDITOR='code -w -n'

compdef _files copychat