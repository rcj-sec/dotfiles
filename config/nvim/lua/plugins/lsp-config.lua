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
                ensure_installed = { "lua_ls", "zls", "clangd", "bashls" }
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
        end
    }
}
