vim.g.mapleader = " "

local builtin = require("telescope.builtin")

-- ALT + e = open explorer
vim.keymap.set({ "n", "i", "v" }, "<M-e>", "<Esc>:Explore<CR>", { noremap = true, silent = true })

-- ALT + n = toggle neotree
vim.keymap.set({ "n", "i", "v" }, "<M-n>", "<Esc>:Neotree toggle<CR>", { noremap = true, silent = true })

-- ALT + w = :w
vim.keymap.set({ "n", "i", "v" }, "<M-w>", "<Esc>:w<CR>", { noremap = true, silent = true })

-- ALT + q = :q
vim.keymap.set({ "n", "i", "v" }, "<M-q>", "<Esc>:q<CR>", { noremap = true, silent = true })

-- leader + ff = telescope fuzzy find
vim.keymap.set({ "n" }, "<leader>ff", builtin.find_files, { noremap = true, silent = true })

-- leader + lg = telescope live grep
vim.keymap.set({ "n" }, "<leader>lg", builtin.live_grep, { noremap = true, silent = true })

-- leader + fmt = format document
vim.keymap.set({ "n" }, "<leader>fmt", vim.lsp.buf.format, { noremap = true, silent = true })

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
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

local dap = require("dap")

vim.keymap.set("n", "<F8>", dap.continue, { silent = true })
vim.keymap.set("n", "<F9>", dap.step_into, { silent = true })
vim.keymap.set("n", "<F10>", dap.step_over, { silent = true })
vim.keymap.set("n", "<F11>", dap.step_out, { silent = true })
vim.keymap.set("n", "<F12>", dap.toggle_breakpoint, { silent = true })
vim.keymap.set("n", "<leader>dc", require("dapui").close, { silent = true })
