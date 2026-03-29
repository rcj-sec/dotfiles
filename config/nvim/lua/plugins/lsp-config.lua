return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "zls", "clangd", "bashls", "asm_lsp" }
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.diagnostic.config({
                  virtual_text = true, -- enable inline errors
                  signs = false,
                  underline = true,
                  update_in_insert = true,
                  severity_sort = true,
            })

            vim.filetype.add({
                extension = {
                    s = "asm",
                    S = "asm",
                },
            })

            local lsp_util = require("lspconfig.util")

            vim.lsp.config(
                "asm_lsp", 
                {
                cmd = { "asm-lsp" },
                filetypes = { "asm" },
                root_dir = function(fname)
                    return lsp_util.root_pattern(".asm-lsp.toml", ".git")(fname)
                        or vim.fn.getcwd()
                end,
                }
            )

            vim.lsp.config(
                "clangd", 
                {
                    cmd = { "clangd" },
                    filetypes = { "c", "cpp" },
                }
            )

        end
    }
}
