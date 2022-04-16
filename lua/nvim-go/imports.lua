-- do formatting via lsp
local function imports()
	local params = vim.lsp.util.make_range_params()
	params.context = {only = {"source.organizeImports"}}

	-- TODO: make callback wait time configurable at plugin level
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end

return {
	imports = imports
}
