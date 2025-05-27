# VSCode

**NO AI version**. For newbie learning.

Applicable only for last two release of VSCode. If you need older version, please see commit history

## macOS / Linux

Just run

```sh
./install-[stable|insider].sh
```

## Tuning

Disable workspace specific extensions or RAM-hungry extensions

- Not all extensions are listed
- Disable these extensions to save CPU and memory when not needed

| Name                       | Global | Workspace | High resource usage  |
| -------------------------- | ------ | --------- | -------------------- |
| CodeSpell + All langs      | -      | -         | CPU/RAM              |
| Deno                       | -      | +         | RAM                  |
| i18n ally                  | -      | -         | RAM                  |
| Stylelint                  | -      | +         | CPU/RAM              |
| `vscode-styled-components` | -      | +         | CPU/RAM              |
| Pretty TS Errors           | -      | -         | CPU/RAM              |
| Bash IDE                   | -      | +         | CPU/RAM              |
| biome                      | -      | +         | CPU?                 |
| CodeLLDB                   | -      | +         | CPU/RAM              |
| dprint                     | -      | +         | CPU?                 |
| ESLint                     | -      | +         | CPU/RAM              |
| Figma                      | -      | +         | CPU/RAM              |
| GH Actions                 | -      | +         | CPU/RAM              |
| GH PR and Issues           | -      | +         | CPU/RAM              |
| HTMLHint                   | -      | +         | RAM                  |
| PowerShell                 | -      | +         |                      |
| SQLTools                   | -      | +         | RAM                  |
| Dev DB                     | -      | +         | RAM                  |
| Database Client            | -      | +         | RAM                  |
| MongoDB                    | -      | +         | RAM                  |
| quick-lint-js              | -      | +         | CPU                  |
| Thunder Client             | -      | +         |                      |
| Shellcheck                 | -      | -         | **Bash IDE** or this |

## Post-installation

Just reboot VSCode

## Supported versions

Latest **1 versions** at best and **2 versions** at support of VSCode (Insiders) are supported

## FAQ

### Installation failed or not found

Check if you before installed this script, on **Code/Code Insider** folder should be **User** linked folder. Delete that and re-try install
