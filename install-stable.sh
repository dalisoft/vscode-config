#!/bin/bash
set -e

APPS_PATH=""
INSTALLED_EXTENSIONS=()

if [[ $(uname) == "Darwin" ]]; then
  APPS_PATH="$HOME/Library/Application Support"
elif [[ $(uname) == "Linux" ]]; then
  APPS_PATH = "$HOME/.config"
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

  if [[ $1 == "-p" ]]; then
    patch -ts -p1 <legacy.patch
  fi

  echo "Done for VSCode"
fi
