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
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldmethod = "expr"
vim.o.foldlevel = 99

function _G.my_foldtext()
  local line = vim.fn.getline(vim.v.foldstart)
  local lines = vim.v.foldend - vim.v.foldstart + 1
  return line .. " { " .. lines .. " lines }"
end

vim.opt.foldtext = "v:lua.my_foldtext()"

vim.api.nvim_set_hl(0, "Folded", {fg = "#00FFFF", italic = true })
