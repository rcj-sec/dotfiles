return {
    "abecodes/tabout.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("tabout").setup {
            tabkey = '<Tab>', -- key to trigger tabout, set to '<Tab>' by default
            backwards_tabkey = '<S-Tab>', -- key to go backwards
            act_as_tab = true,  -- tab key will insert a tab if no tabout is possible
            act_as_shift_tab = false,
            enable_backwards = true,
            completion = true,
            ignore_beginning = false,
            exclude = {},
            tabout = {
                {open = '"', close = '"'},
                {open = "'", close = "'"},
                {open = "`", close = "`"},
                {open = '(', close = ')'},  -- <<< Add this
                {open = '[', close = ']'},
                {open = '{', close = '}'},
            }
        }
    end
}

