local M = {}

local ts_utils = require'nvim-treesitter.ts_utils'

function M.get_function_name_at_cursor()
	local current_node = ts_utils.get_node_at_cursor()
	if not current_node then
		return
	end

	local exp = current_node
	while exp do
		if exp:type() == 'function_declaration' then
			break
		end
		exp = exp:parent()
	end

	if not exp then
		return
	end

	return vim.treesitter.query.get_node_text(exp:child(1), 0)
end

function M.get_functions_in_file()
	local results = {}

	local current_node = ts_utils.get_node_at_cursor()
	if not current_node then
		return
	end

	local exp = current_node
	while exp do
		if exp:type() == 'source_file' then
			break
		end

		exp = exp:parent()
	end

	for child, _ in exp:iter_children() do
		if child:type() == 'function_declaration' then
			table.insert(results, vim.treesitter.query.get_node_text(child:child(1), 0))
		end
	end

	return results
end

return M
