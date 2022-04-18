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

return M
