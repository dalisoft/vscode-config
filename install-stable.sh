#!/bin/sh

TARGET_PATH=""

if [[ $(uname) == "Darwin" ]]; then
  TARGET_PATH="$HOME/Library/Application\ Support/Code"
elif [[ $(uname) == "Linux" ]]; then
  TARGET_PATH = "$HOME/.config/Code"
fi

cp settings.config.json Code/User/settings.json

if [[ $(type -p code) != "" ]]; then
  echo "Found VSCode, installating..."
  cat extensions.txt | xargs -L1 code --install-extension

  bash -c "rm -r $TARGET_PATH/User"
  bash -c "ln -s $PWD/Code/User/ $TARGET_PATH/User"

  if [[ $1 == "-p" ]]; then
    patch -ts -p1 <legacy.patch
  fi

  echo "Done for VSCode"
fi
