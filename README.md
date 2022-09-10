# VSCode settings

## macOS

```sh
cat extensions.txt | xargs -L1 code --force --install-extension
rm -rf ~/Library/Application\ Support/Code/User
ln -s $PWD/User ~/Library/Application\ Support/Code/User
```

## Linux

```sh
cat extensions.txt | xargs -L1 code --force --install-extension
rm -rf ~/.config/Code/User
ln -s $PWD/User ~/.config/Code/User
```

## Post-installation

Just reboot VSCode
