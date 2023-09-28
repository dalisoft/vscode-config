#!/bin/sh
set -e

APPS_PATH=""
INSTALLED_EXTENSIONS=()

if [[ $(uname) == "Darwin" ]]; then
  APPS_PATH="$HOME/Library/Application Support"
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
elif [[ $(uname) == "Linux" ]]; then
  APPS_PATH="$HOME/.config"
elif [[ $(uname) == *"NT"* ]]; then
  echo "We found Windows NT environment"
  echo "Installation will not work"

  exit 1
fi

cp settings.config.json Code/User/settings.json

if [[ $(type -p code) != "" ]]; then
  echo "Found VSCode, installing configs..."

  INSTALLED_EXTENSIONS=$(code --list-extensions)
  cat extensions.txt | while read ext; do
    if [[ $(echo "$INSTALLED_EXTENSIONS" | grep -o "$ext") == "$ext" ]]; then
      echo "Already exists extension: $ext"
    else
      code --install-extension $ext || echo "Failed to install: $ext"
    fi
  done

  rm -r "$APPS_PATH"/Code/User
  ln -s $PWD/Code/User/ "$APPS_PATH"/Code/User

  echo "Done for VSCode"
fi
