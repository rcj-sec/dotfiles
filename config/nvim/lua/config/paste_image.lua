vim.keymap.set("n", "<leader>pp", function()
	local manager = require("neo-tree.sources.manager")
	local state = manager.get_state("filesystem")
	local node = state.tree:get_node()
	local path = node.path

	local uv = vim.loop
	local stat = uv.fs_stat(path)

	local target_dir
	if stat and stat.type == "directory" then
		target_dir = path
	else
		target_dir = vim.fn.fnamemodify(path, ":h")
	end

	vim.ui.input({ prompt = "Image filename (without .png): " }, function(input)
		if not input or input == "" then
			print("Cancelled or empty filename.")
			return
		end

		local full_path = target_dir .. "/" .. input .. ".png"

		local function save_image()
			local cmd = string.format("wl-paste --type image/png > %q", full_path)
			vim.cmd("silent !" .. cmd)
			require("neo-tree.sources.filesystem.commands").refresh(state)
			print("Image saved as " .. full_path)
		end

		if uv.fs_stat(full_path) then
			vim.ui.input({ prompt = "File exists. Overwrite? (y/N): " }, function(answer)
				if answer and answer:lower() == "y" then
					save_image()
				else
					print("Cancelled. File was not overwritten.")
				end
			end)
		else
			save_image()
		end
	end)
end, { desc = "Paste image to selected Neo-tree folder with filename and overwrite check" })
