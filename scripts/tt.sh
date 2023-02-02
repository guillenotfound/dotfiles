#!/bin/bash

REPOS_DIR=${REPOS:-~/repos}

ZOXIDE_RESULT=`zoxide query -l`
REPOSITORIES_RESULT=`fd -I --type d -g '.git' -H $REPOS_DIR -x dirname`

ALL_RESULTS=( "${ZOXIDE_RESULT[@]}" "${REPOSITORIES_RESULT[@]}" )

ZOXIDE_RESULT=$(printf "%s\n" "${ALL_RESULTS[@]}" | awk '!x[$0]++' | fzf --reverse)

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
