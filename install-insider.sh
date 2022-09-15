#!/bin/sh

TARGET_PATH=""

if [[ $(uname) == "Darwin" ]]; then
  TARGET_PATH="~/Library/Application\ Support/Code\ -\ Insiders"
elif [[ $(uname) == "Linux" ]]; then
  TARGET_PATH = "~/.config/Code\ -\ Insiders"
fi

if [[ $(type -p code-insiders) != "" ]]; then
  echo "Found VSCode Insiders, installating..."
  cat extensions.txt | xargs -L1 code-insiders --install-extension
  cp -R Code/ Code\ -\ Insiders
  rm -rf Code\ -\ Insiders/User/settings.json
  cp settings.config.json Code\ -\ Insiders/User/settings.json

  bash -c "rm -r $TARGET_PATH/User"
  bash -c "ln -s $PWD/Code/User/ $TARGET_PATH/User"

  if [[ $1 == "-p" ]]; then
    patch -ts -p1 <legacy-insiders.patch
  fi

  echo "Done for VSCode Insiders"
fi
