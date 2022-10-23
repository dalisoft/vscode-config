$APPS_PATH = "~\Application Data"

taskkill /IM code.exe /F;
Copy-Item settings.config.json Code/User/settings.json;

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

  [System.IO.Directory]::Delete("Application Data\Code\User" , $true)
  New-Item -ItemType SymbolicLink -Path "$APPS_PATH\Code\User" -Target "$PSScriptRoot\Code\User\" -Force;

  if ($args[0] -eq "-p") {
    patch -ts -p1 legacy.patch;
  }

  Write-Output "Done for VSCode";
  Write-Output "You can now launch your VSCode instance";
}
