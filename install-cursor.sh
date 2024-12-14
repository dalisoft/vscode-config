#!/bin/sh
set -e

APPS_PATH=""
INSTALLED_EXTENSIONS=""

if [ "$(uname)" = "Darwin" ]; then
  APPS_PATH="$HOME/Library/Application Support"
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
elif [ "$(uname)" = "Linux" ]; then
  APPS_PATH="$HOME/.config"
elif [ "$(uname)" = "*NT*" ]; then
  echo "We found Windows NT environment"
  echo "Installation will not work"

  exit 1
fi

mkdir -p "$APPS_PATH/Cursor/User"
cp settings.config.jsonc "$APPS_PATH/Cursor/User/settings.json"
cp keybindings.json "$APPS_PATH/Cursor/User/keybindings.json"

if [ -n "$(type cursor)" ]; then
  echo "Found Cursor, installing configs..."

  INSTALLED_EXTENSIONS=$(code --list-extensions)
  cat extensions.txt | while read -r ext; do
    if [ "$(echo "$INSTALLED_EXTENSIONS" | grep -o "$ext")" = "$ext" ]; then
      echo "Already exists extension: $ext"
    else
      cursor --install-extension "$ext" || echo "Failed to install: $ext"
    fi
  done

  echo "Done for Cursor"
fi