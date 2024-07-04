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

mkdir -p "$APPS_PATH/Code/User"
cp settings.config.jsonc "$APPS_PATH/Code/User/settings.json"

if [ -n "$(type code)" ]; then
  echo "Found VSCode, installing configs..."

  INSTALLED_EXTENSIONS=$(code --list-extensions)
  cat extensions.txt | while read -r ext; do
    if [ "$(echo "$INSTALLED_EXTENSIONS" | grep -o "$ext")" = "$ext" ]; then
      echo "Already exists extension: $ext"
    else
      code --install-extension "$ext" || echo "Failed to install: $ext"
    fi
  done

  echo "Done for VSCode"
fi
