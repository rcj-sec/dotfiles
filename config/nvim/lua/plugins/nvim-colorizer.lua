return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        vim.opt.termguicolors = true
        require("colorizer").setup({
            "*",                                           -- Enable for all filetypes
            css = { css = true },
            rasi = { names = false, rgb_fn = true, hsl_fn = true }, -- optional for .rasi
        })
    end,
}
