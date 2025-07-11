#!/bin/sh
set -e

APPS_PATH=""
INSTALLED_EXTENSIONS=""

if [ "$(uname)" = "Darwin" ]; then
  APPS_PATH="$HOME/Library/Application Support"
  defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
elif [ "$(uname)" = "Linux" ]; then
  APPS_PATH="$HOME/.config"
elif [ "$(uname)" = "*NT*" ]; then
  echo "We found Windows NT environment"
  echo "Installation will not work"

  exit 1
fi

mkdir -p "$APPS_PATH/Code - Insiders/User"
cp settings.config.json "$APPS_PATH/Code - Insiders/User/settings.json"
cp keybindings.json "$APPS_PATH/Code - Insiders/User/keybindings.json"

if [ -n "$(type code-insiders)" ]; then
  echo "Found VSCode Insiders, installation..."

  INSTALLED_EXTENSIONS=$(code-insiders --list-extensions)
  cat extensions.txt | while read -r ext; do
    if [ "$(echo "$INSTALLED_EXTENSIONS" | grep -o "$ext")" = "$ext" ]; then
      echo "Already exists extension: $ext"
    else
      code-insiders --install-extension "$ext" || echo "Failed to install: $ext"
    fi
  done

  echo "Done for VSCode Insiders"
fi
