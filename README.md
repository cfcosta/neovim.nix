# Nightvim

A Nix-native Neovim config, with everything you expect:

* LSP Config (tools included)
* Format on Save (formatters included)
* AI Support

## Try It!

You can try it without messing around your system at all (everything is self-contained):

```shell
nix run github:cfcosta/neovim.nix#
```

## Keybindings

### fff
fuzzy finder for files.

| key              | mode | description                    |
|------------------|------|--------------------------------|
| `<leader><leader>` | n    | find files                    |

### NvimTree
File explorer tree view.

| Key         | Mode | Description      |
|-------------|------|------------------|
| `<leader>op` | n    | Toggle NvimTree |

In NvimTree window:
| Key | Mode | Description                  |
|-----|------|------------------------------|
| `s` | n    | Open in vertical split      |
| `v` | n    | Open in horizontal split    |

### telescope
fuzzy finder for files, buffers, and more.

| key              | mode | description                    |
|------------------|------|--------------------------------|
| `<leader>/`      | n    | live grep                     |
| `<leader>bb`     | n    | open buffers                  |

In Telescope window:
| Key      | Mode | Description              |
|----------|------|--------------------------|
| `<c-t>`  | n, i | Open with Trouble       |
| `<c-a>`  | n, i | Add to Trouble          |
| `q`      | n    | Close                   |
| `<esc>`  | i    | Close                   |

### LSP
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

### Trouble
A pretty diagnostics, references, telescope results, quickfix and location list.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>xx`  | n    | Toggle diagnostics                    |
| `<leader>xX`  | n    | Toggle buffer diagnostics             |
| `<leader>cs`  | n    | Toggle symbols                        |
| `<leader>cl`  | n    | Toggle LSP                           |
| `<leader>xL`  | n    | Toggle location list                  |
| `<leader>xQ`  | n    | Toggle quickfix list                  |

### Toggleterm
Terminal management within Neovim.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>]`   | n    | Send current line to terminal         |
| `<leader>oF`  | n    | Open terminal in new tab             |
| `<leader>oT`  | n    | Open terminal in vertical split      |
| `<leader>of`  | n    | Open floating terminal               |
| `<leader>ot`  | n    | Open terminal in horizontal split    |

### Obsidian
Note-taking and knowledge base with Obsidian vault integration.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>nn`  | n    | Quick switch note                     |
| `<leader>nd`  | n    | Find daily notes                      |
| `<leader>nT`  | n    | Open tomorrow's note                  |
| `<leader>n/`  | n    | Search notes                          |
| `<leader>nt`  | n    | Open today's note                     |
| `<leader>ny`  | n    | Open yesterday's note                 |

### Todo Comments
Todo comment tracking and management.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>tt`  | n    | Find comments with Telescope          |
| `<leader>xt`  | n    | Find comments with Trouble            |

### Grug Far
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

### Rustacean
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

### Neotest
Testing framework integration.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>ss`  | n    | Run nearest test                     |
| `<leader>sf`  | n    | Run tests on current file            |

### Window Management
Built-in window management commands.

| Key           | Mode | Description                           |
|---------------|------|---------------------------------------|
| `<leader>wv`  | n    | Split window vertically              |
| `<leader>ws`  | n    | Split window horizontally            |
| `<leader>wc`  | n    | Close current window                 |
| `<leader>wo`  | n    | Close all windows except current     |
