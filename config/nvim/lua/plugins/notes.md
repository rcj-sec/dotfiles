# Notes on Mason, LSPs, lspconfig, Tree-sitter, and none-ls

## What are they 

- **Tree-sitter** is for syntax highlighting and parsing structure
    - Set `auto_install = true` to automatically install parsers when detected a new laguage

- **Mason** is the GUI tool to install formatters, LSPs, linters, etc...
    - Think of it as an API or abstraction to install LSPs from nvim-lspconfig and, formatter/linters from none-ls

- **nvim-lspconfig** is the interface for neovim to talk to installed LSPs
    - Does not install anything
    - Connects to already installed LSPs
    
- **mason-lspconfig** is the bridge between **Mason** and **nvim-lspconfig**

- **none-ls** presents linters and formatters as LSPs so neovim can read from them 

## How to install a parser

- It is done automatically by tree-sitter

## How to install LSP

- Download it from Mason
- Specify `vim.lsp.enable = lua_ls` (to install lua LSP `lua_ls`)

## How to install parsers or formatters

- Download it from Mason
- Specify `null_ls.builtins.formatters.clangd_format` (for the `clang-format` formatter)
- Or if it's a linter `null_ls.builtins.diagnostics.rubocop` (for the ruby linter `rubocop`)
