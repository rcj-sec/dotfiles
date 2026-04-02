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


            vim.lsp.config(
                "asm_lsp",
                {
                    cmd = { "asm-lsp" },
                    filetypes = { "asm" },
                    handlers = {
                        ["textDocument/publishDiagnostics"] = function() end,
                    },
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
