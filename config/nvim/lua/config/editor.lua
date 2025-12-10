vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.opt.number = true

vim.api.nvim_create_autocmd(
    {"InsertEnter"},
    {
        pattern = "*",
        callback = function()
            vim.opt.number = true
            vim.opt.relativenumber = false
        end,
    }
)

vim.api.nvim_create_autocmd(
    {"InsertLeave"},
    {
        pattern = "*",
        callback = function()
            vim.opt.number = true
            vim.opt.relativenumber = true
        end,
    }
)

vim.filetype.add({ extension = { rasi = "rasi" } })
