$APPS_PATH = "~\Application Data"

taskkill /IM code-insiders.exe /F;

New-Item -ItemType Directory -Path "$APPS_PATH/Code - Insiders/User" -Force | Out-Null

Copy-Item -Path "settings.config.json" -Destination "$APPS_PATH/Code - Insiders/User/settings.json" -Force
Copy-Item -Path "keybindings.json" -Destination "$APPS_PATH/Code - Insiders/User/keybindings.json" -Force

if (Get-Command code-insiders -errorAction SilentlyContinue) {
  Write-Output "Found VSCode Insiders, installing configs...";

  $INSTALLED_EXTENSIONS = $(code-insiders --list-extensions);
  foreach ($ext in Get-Content .\extensions.txt) {
    if ($INSTALLED_EXTENSIONS -match $ext) {
      Write-Output "Already exists extension: $ext";
    }
    else {
      if ($?) {
        code-insiders --install-extension $ext
      }
      else {
        Write-Output "Failed to install: $ext";
      }
    }
  }

  if ($args[0] eq "--ai") {
    foreach ($ext in Get-Content .\ai.txt) {
      if ($INSTALLED_EXTENSIONS -match $ext) {
        Write-Output "Already exists extension: $ext";
      }
      else {
        if ($?) {
          code-insiders --install-extension $ext
        }
        else {
          Write-Output "Failed to install: $ext";
        }
      }
    }
  }

  Write-Output "Done for VSCode Insiders";
  Write-Output "You can now launch your VSCode Insiders instance";
}
