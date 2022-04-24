local M = {}

function M.setupLspInstaller()
	local lsp_installer_status_ok, lsp_installer = pcall(require, "nvimv-lsp-installer")
	if not lsp_installer_status_ok then
		return
	end

	-- setup Gopls server
	lsp_installer.on_server_ready(function(server)
		if server.name == "gopls" then
			server:setup({
				cmd = {"gopls", "serve"},
				filetypes = { "go", "gomod", "gotmpl", "go.mod" },
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
					},
				},
			})
		end

	end)
end

function M.format()
	vim.lsp.buf.formatting()
end

function M.imports()
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

function M.rename()
	vim.lsp.buf.rename()
end

return M
