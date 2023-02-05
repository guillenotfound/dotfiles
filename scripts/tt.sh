#!/bin/bash

ZOXIDE_RESULT=`zoxide query -l | fzf --reverse`

if [ -z "$ZOXIDE_RESULT" ]; then
  exit 0
fi

FOLDER=$(basename $ZOXIDE_RESULT)
SESSION_NAME=$(echo $FOLDER | tr ' ' '_' | tr '.' '_')

# lookup tmux session name
SESSION=$(tmux list-sessions | grep -F $SESSION_NAME | awk '{print $1}')
SESSION=${SESSION//:/}

if [ -z "$SESSION" ]; then
  # session does not exist
  # jump to directory
  cd "$ZOXIDE_RESULT"
  # create session
  tmux new-session -d -s $SESSION_NAME
  # attach to session
  tmux switch-client -t $SESSION_NAME
else
  tmux switch-client -t $SESSION
fi
