#!/bin/sh

APPS_PATH=""

if [[ $(uname) == "Darwin" ]]; then
  APPS_PATH="$HOME/Library/Application Support"
elif [[ $(uname) == "Linux" ]]; then
  APPS_PATH = "$HOME/.config"
fi

cp settings.config.json Code/User/settings.json

if [[ $(type -p code) != "" ]]; then
  echo "Found VSCode, installating..."
  cat extensions.txt | xargs -L1 code --install-extension
  rm -r "$APPS_PATH"/Code/User
  ln -s $PWD/Code/User/ "$APPS_PATH"/Code/User

  if [[ $1 == "-p" ]]; then
    patch -ts -p1 <legacy.patch
  fi

  echo "Done for VSCode"
fi
