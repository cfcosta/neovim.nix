# Keybindings

## Avante
AI code assistance and completion plugin.

No default keybindings defined.

## NvimTree
File explorer tree view.

| Key         | Mode | Description      |
|-------------|------|------------------|
| `<leader>op` | n    | Toggle NvimTree |

In NvimTree window:
| Key | Mode | Description                  |
|-----|------|------------------------------|
| `s` | n    | Open in vertical split      |
| `v` | n    | Open in horizontal split    |

## Telescope
Fuzzy finder for files, buffers, and more.

| Key              | Mode | Description                    |
|------------------|------|--------------------------------|
| `<leader><leader>` | n    | Find files                    |
| `<leader>/`      | n    | Live grep                     |
| `<leader>bb`     | n    | Open buffers                  |
| `<leader>gc`     | n    | Git commits                   |
| `<leader>gs`     | n    | Git status                    |
| `<leader>ct`     | n    | LSP workspace symbols         |

In Telescope window:
| Key      | Mode | Description              |
|----------|------|--------------------------|
| `<c-t>`  | n, i | Open with Trouble       |
| `<c-a>`  | n, i | Add to Trouble          |
| `q`      | n    | Close                   |
| `<esc>`  | i    | Close                   |

## LSP
Language Server Protocol support for code intelligence.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `gd`          | n    | Go to declaration                     |
| `gD`          | n    | Go to definition                      |
| `K`           | n    | Show hover information                |
| `gi`          | n    | Go to implementation                  |
| `<leader>ls`  | n    | Show signature help                   |
| `<leader>D`   | n    | Go to type definition                 |
| `<leader>ca`  | n    | Code action                          |
| `<leader>cF`  | n    | Open diagnostic float                |
| `[d`          | n    | Go to previous diagnostic            |
| `d]`          | n    | Go to next diagnostic                |
| `<leader>cq`  | n    | Set diagnostics to location list     |
| `<leader>cr`  | n    | Rename symbol                        |

## Trouble
A pretty diagnostics, references, telescope results, quickfix and location list.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>xx`  | n    | Toggle diagnostics                    |
| `<leader>xX`  | n    | Toggle buffer diagnostics             |
| `<leader>cs`  | n    | Toggle symbols                        |
| `<leader>cl`  | n    | Toggle LSP                           |
| `<leader>xL`  | n    | Toggle location list                  |
| `<leader>xQ`  | n    | Toggle quickfix list                  |

## Toggleterm
Terminal management within Neovim.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>]`   | n    | Send current line to terminal         |
| `<leader>oF`  | n    | Open terminal in new tab             |
| `<leader>oT`  | n    | Open terminal in vertical split      |
| `<leader>of`  | n    | Open floating terminal               |
| `<leader>ot`  | n    | Open terminal in horizontal split    |

## Zen Mode
Distraction-free coding environment.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>zz`  | n    | Toggle Zen Mode                      |

## Obsidian
Note-taking and knowledge base with Obsidian vault integration.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>nn`  | n    | Switch to a note                     |
| `<leader>nd`  | n    | Find journal entries                 |
| `<leader>nT`  | n    | Open journal entry for tomorrow      |
| `<leader>ns`  | n    | Search notes                         |
| `<leader>nt`  | n    | Open journal entry for today         |
| `<leader>ny`  | n    | Open journal entry for yesterday     |

## Grug Far
Advanced search and replace across files.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>fr`  | n    | Replace files in project             |

In Grug Far window:
| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>r`   | n    | Replace                              |
| `<leader>q`   | n    | Quickfix list                        |
| `<leader>s`   | n    | Sync locations                       |
| `<leader>l`   | n    | Sync line                            |
| `<leader>c`   | n    | Close                                |
| `<leader>t`   | n    | Open history                         |
| `<leader>a`   | n    | Add to history                       |
| `<leader>f`   | n    | Refresh                              |
| `<leader>o`   | n    | Open location                        |
| `<down>`      | n    | Open next location                   |
| `<up>`        | n    | Open previous location               |
| `<enter>`     | n    | Go to location/Pick history entry    |
| `<leader>b`   | n    | Abort                                |
| `g?`          | n    | Help                                 |
| `<leader>p`   | n    | Toggle show command                  |
| `<leader>e`   | n    | Swap engine                          |
| `<leader>i`   | n    | Preview location                     |

## Rustacean
Enhanced Rust development environment.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>j`   | v    | Join lines                            |
| `<leader>cc`  | n    | Code actions                         |
| `<leader>rr`  | n    | Run checks                           |
| `<leader>rh`  | n    | View HIR                             |
| `<leader>rm`  | n    | View MIR                             |
| `<leader>rt`  | n    | Run test                             |
| `<leader>rT`  | n    | Run last ran test                    |
| `<leader>rd`  | n    | Open rustdoc for symbol under cursor|

## Neotest
Testing framework integration.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>ss`  | n    | Run nearest test                     |
| `<leader>sf`  | n    | Run tests on current file            |

## Window Management
Built-in window management commands.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>wv`  | n    | Split window vertically              |
| `<leader>ws`  | n    | Split window horizontally            |
| `<leader>wc`  | n    | Close current window                 |
| `<leader>wo`  | n    | Close all windows except current     |
