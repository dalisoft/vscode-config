$APPS_PATH = "~\Application Data"

taskkill /IM cursor.exe /F;

New-Item -ItemType Directory -Path "$APPS_PATH/Cursor/User" -Force | Out-Null

Copy-Item -Path "settings.config.json" -Destination "$APPS_PATH/Cursor/User/settings.json" -Force
Copy-Item -Path "keybindings.json" -Destination "$APPS_PATH/Cursor/User/keybindings.json" -Force

if (Get-Command cursor -errorAction SilentlyContinue) {
  Write-Output "Found Cursor, installing configs...";

  $INSTALLED_EXTENSIONS = $(cursor --list-extensions);
  foreach ($ext in Get-Content .\extensions.txt) {
    if ($INSTALLED_EXTENSIONS -match $ext) {
      Write-Output "Already exists extension: $ext";
    }
    else {
      if ($?) {
        cursor --install-extension $ext
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
          cursor --install-extension $ext
        }
        else {
          Write-Output "Failed to install: $ext";
        }
      }
    }
  }

  Write-Output "Done for Cursor";
  Write-Output "You can now launch your Cursor instance";
}
