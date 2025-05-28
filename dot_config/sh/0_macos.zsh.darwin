



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


alias devcontainer="devcontainer-insiders"
export EDITOR='code -w -n'

ghcs() {
        FUNCNAME="$funcstack[1]"
        TARGET="shell"
        local GH_DEBUG="$GH_DEBUG"
        local GH_HOST="$GH_HOST"

        read -r -d '' __USAGE <<-EOF
        Wrapper around \`gh copilot suggest\` to suggest a command based on a natural language description of the desired output effort.
        Supports executing suggested commands if applicable.

        USAGE
          $FUNCNAME [flags] <prompt>

        FLAGS
          -d, --debug           Enable debugging
          -h, --help            Display help usage
              --hostname        The GitHub host to use for authentication
          -t, --target target   Target for suggestion; must be shell, gh, git
                                default: "$TARGET"

        EXAMPLES

        - Guided experience
          $ $FUNCNAME

        - Git use cases
          $ $FUNCNAME -t git "Undo the most recent local commits"
          $ $FUNCNAME -t git "Clean up local branches"
          $ $FUNCNAME -t git "Setup LFS for images"

        - Working with the GitHub CLI in the terminal
          $ $FUNCNAME -t gh "Create pull request"
          $ $FUNCNAME -t gh "List pull requests waiting for my review"
          $ $FUNCNAME -t gh "Summarize work I have done in issues and pull requests for promotion"

        - General use cases
          $ $FUNCNAME "Kill processes holding onto deleted files"
          $ $FUNCNAME "Test whether there are SSL/TLS issues with github.com"
          $ $FUNCNAME "Convert SVG to PNG and resize"
          $ $FUNCNAME "Convert MOV to animated PNG"
EOF

        local OPT OPTARG OPTIND
        while getopts "dht:-:" OPT; do
                if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
                        OPT="${OPTARG%%=*}"       # extract long option name
                        OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
                        OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
                fi

                case "$OPT" in
                        debug | d)
                                GH_DEBUG=api
                                ;;

                        help | h)
                                echo "$__USAGE"
                                return 0
                                ;;

                        hostname)
                                GH_HOST="$OPTARG"
                                ;;

                        target | t)
                                TARGET="$OPTARG"
                                ;;
                esac
        done

        # shift so that $@, $1, etc. refer to the non-option arguments
        shift "$((OPTIND-1))"

        TMPFILE="$(mktemp -t gh-copilotXXXXXX)"
        trap 'rm -f "$TMPFILE"' EXIT
        if GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot suggest -t "$TARGET" "$@" --shell-out "$TMPFILE"; then
                if [ -s "$TMPFILE" ]; then
                        FIXED_CMD="$(cat $TMPFILE)"
                        print -s -- "$FIXED_CMD"
                        echo
                        eval -- "$FIXED_CMD"
                fi
        else
                return 1
        fi
}

ghce() {
        FUNCNAME="$funcstack[1]"
        local GH_DEBUG="$GH_DEBUG"
        local GH_HOST="$GH_HOST"

        read -r -d '' __USAGE <<-EOF
        Wrapper around \`gh copilot explain\` to explain a given input command in natural language.

        USAGE
          $FUNCNAME [flags] <command>

        FLAGS
          -d, --debug      Enable debugging
          -h, --help       Display help usage
              --hostname   The GitHub host to use for authentication

        EXAMPLES

        # View disk usage, sorted by size
        $ $FUNCNAME 'du -sh | sort -h'

        # View git repository history as text graphical representation
        $ $FUNCNAME 'git log --oneline --graph --decorate --all'

        # Remove binary objects larger than 50 megabytes from git history
        $ $FUNCNAME 'bfg --strip-blobs-bigger-than 50M'
EOF

        local OPT OPTARG OPTIND
        while getopts "dh-:" OPT; do
                if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
                        OPT="${OPTARG%%=*}"       # extract long option name
                        OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
                        OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
                fi

                case "$OPT" in
                        debug | d)
                                GH_DEBUG=api
                                ;;

                        help | h)
                                echo "$__USAGE"
                                return 0
                                ;;

                        hostname)
                                GH_HOST="$OPTARG"
                                ;;
                esac
        done

        # shift so that $@, $1, etc. refer to the non-option arguments
        shift "$((OPTIND-1))"

        GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot explain "$@"
}



