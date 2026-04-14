#!/usr/bin/env bash
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten home directory
home="$HOME"
if [ -n "$cwd" ]; then
  short_cwd="${cwd/#$home/~}"
else
  short_cwd="$(pwd)"
fi

parts=""

# Current directory
parts="${parts}$(printf '\033[0;34m%s\033[0m' "$short_cwd")"

# Model name
if [ -n "$model" ]; then
  parts="${parts} $(printf '\033[0;33m[%s]\033[0m' "$model")"
fi

# Context usage
if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  if [ "$used_int" -ge 80 ]; then
    color='\033[0;31m'
  elif [ "$used_int" -ge 50 ]; then
    color='\033[0;33m'
  else
    color='\033[0;32m'
  fi
  parts="${parts} $(printf "${color}ctx:%s%%\033[0m" "$used_int")"
fi

printf '%s' "$parts"
