vim.g.mapleader = " "

local builtin = require("telescope.builtin")

-- leader + rn = LSP rename
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- ALT + e = switch between files back and forth
vim.keymap.set({ "n", "i", "v" }, "<M-e>", "<C-^>", { noremap = true, silent = true })

-- ALT + n = toggle neotree
vim.keymap.set({ "n", "i", "v" }, "<M-n>", "<Esc>:Neotree toggle<CR>", { noremap = true, silent = true })

-- ALT + s = :w
vim.keymap.set({ "n", "i", "v" }, "<M-s>", "<Esc>:w<CR>", { noremap = true, silent = true })

-- ALT + t = :q
vim.keymap.set({ "n", "i", "v" }, "<M-t>", "<Esc>:q<CR>", { noremap = true, silent = true })

-- leader + ff = telescope fuzzy find
vim.keymap.set({ "n" }, "<leader>ff", builtin.find_files, { noremap = true, silent = true })

-- leader + lg = telescope live grep
vim.keymap.set({ "n" }, "<leader>lg", builtin.live_grep, { noremap = true, silent = true })

-- leader + ft = format document
vim.keymap.set({ "n" }, "<leader>ft", vim.lsp.buf.format, { noremap = true, silent = true })

-- leader + dd = float diagnostics
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, {
    desc = "Open diagnostic",
})

-- shift + k = lsp hover function details in normal mode
vim.keymap.set({ "n" }, "K", vim.lsp.buf.hover, { noremap = true, silent = true })

-- shift + d = lsp go to definition in normal mode
vim.keymap.set({ "n" }, "D", vim.lsp.buf.definition, { noremap = true, silent = true })

-- shift + c = code actions in normal mode
vim.keymap.set({ "n" }, "C", vim.lsp.buf.code_action, { noremap = true, silent = true })

-- do not lose selection after indent
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

--navigate windows with ctrl + hjkl
vim.keymap.set("n", "<M-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<M-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<M-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<M-l>", ":wincmd l<CR>")

local dap = require("dap")

vim.keymap.set("n", "<F8>", dap.continue, { silent = true })
vim.keymap.set("n", "<F9>", dap.step_into, { silent = true })
vim.keymap.set("n", "<F10>", dap.step_over, { silent = true })
vim.keymap.set("n", "<F11>", dap.step_out, { silent = true })
vim.keymap.set("n", "<F12>", dap.toggle_breakpoint, { silent = true })
vim.keymap.set("n", "<leader>dc", require("dapui").close, { silent = true })

vim.keymap.set("x", "<leader>s", "<Plug>(nvim-surround-visual)", {
    desc = "Surround selection",
})

vim.keymap.set("n", "<leader>fr", ":%s/", {
    desc = "Find and replace",
})
