#!/bin/bash
set -e

APPS_PATH=""

if [[ $(uname) == "Darwin" ]]; then
  APPS_PATH="$HOME/Library/Application Support"
elif [[ $(uname) == "Linux" ]]; then
  APPS_PATH = "$HOME/.config"
fi

if [[ $(type -p code-insiders) != "" ]]; then
  echo "Found VSCode Insiders, installating..."
  cat extensions.txt | xargs -L1 code-insiders --install-extension
  cp -R Code/ Code\ -\ Insiders
  cp settings.config.json Code\ -\ Insiders/User/settings.json
  rm -r "$APPS_PATH"/Code\ -\ Insiders/User
  ln -s $PWD/Code/User/ "$APPS_PATH"/Code\ -\ Insiders/User

  if [[ $1 == "-p" ]]; then
    patch -ts -p1 <legacy-insiders.patch
  fi

  echo "Done for VSCode Insiders"
fi
