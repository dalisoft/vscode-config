$APPS_PATH = "~\Application Data"

taskkill /IM code.exe /F;

New-Item -ItemType Directory -Path "$APPS_PATH/Code/User" -Force | Out-Null

Copy-Item -Path "settings.config.json" -Destination "$APPS_PATH/Code/User/settings.json" -Force
Copy-Item -Path "keybindings.json" -Destination "$APPS_PATH/Code/User/keybindings.json" -Force

if (Get-Command code -errorAction SilentlyContinue) {
  Write-Output "Found VSCode, installing configs...";

  $INSTALLED_EXTENSIONS = $(code --list-extensions);
  foreach ($ext in Get-Content .\extensions.txt) {
    if ($INSTALLED_EXTENSIONS -match $ext) {
      Write-Output "Already exists extension: $ext";
    }
    else {
      if ($?) {
        code --install-extension $ext
      }
      else {
        Write-Output "Failed to install: $ext";
      }
    }
  }

  if ($args eq "--ai") {
    foreach ($ext in Get-Content .\ai.txt) {
      if ($INSTALLED_EXTENSIONS -match $ext) {
        Write-Output "Already exists extension: $ext";
      }
      else {
        if ($?) {
          code --install-extension $ext
        }
        else {
          Write-Output "Failed to install: $ext";
        }
      }
    }
  }

  Write-Output "Done for VSCode";
  Write-Output "You can now launch your VSCode instance";
}
