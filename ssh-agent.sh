#!/bin/echo READ THE SOURCE
# This is meant to be sourced, e.g.
# cat <<EOF >> ~/.ashrc
# . $HOME/bin/ssh-agent.sh
# EOF

test -r /dev/urandom || return 1
AFILE=$HOME/.myagent.sh

test -S "$SSH_AUTH_SOCK" && {
  set | grep SSH_AUTH_SOCK; echo "export SSH_AUTH_SOCK";
  echo "echo Using pre-initialized SSH Agent"
} > "$AFILE"

touch "$AFILE" || return 1
until
  . "$AFILE" >/dev/null
  test -S "$SSH_AUTH_SOCK"
do
  ssh-agent -s > "$AFILE" || return 1
done

echo SSH agent pid $SSH_AGENT_PID
unset AFILE
