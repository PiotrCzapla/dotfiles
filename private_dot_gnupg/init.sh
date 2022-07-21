export GPG_TTY=$(tty)

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
       export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

if ! pgrep -x -u "${USER}" gpg-agent &> /dev/null; then
       gpg-connect-agent /bye &> /dev/null
fi

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye > /dev/null