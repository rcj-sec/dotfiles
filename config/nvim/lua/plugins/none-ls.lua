return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.google_java_format,
				null_ls.builtins.formatting.prettierd,
                null_ls.builtins.formatting.shfmt,
				{
					method = null_ls.methods.FORMATTING,
					filetypes = { "zig" },
					generator = null_ls.generator({
						command = "zig",
						args = { "fmt", "--stdin" },
						to_stdin = true,
					}),
				},
			},
		})
	end,
}
