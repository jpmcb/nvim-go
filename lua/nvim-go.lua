local M = {}

local lsp = require "nvim-go.core.lsp"

-- configs values
local config_defaults = {
	setup_lsp_installer = true,
	setup_auto_cmds = true,
}

local function setup_commands()
	vim.cmd [[
		command! GoRename  lua require'nvim-go.core.lsp'.rename()
		command! GoFmt     lua require'nvim-go.core.lsp'.format()
		command! GoImports lua require'nvim-go.core.lsp'.imports()

		command! GoBuild            lua require'nvim-go.build'.build()
		command! GoInstall          lua require'nvim-go.build'.install()
		command! GoTestAll          lua require'nvim-go.test'.test_all()
		command! GoTestAllCover     lua require'nvim-go.test'.test_all_cover()
		command! GoTestPackage      lua require'nvim-go.test'.test_package()
		command! GoTestPackageCover lua require'nvim-go.test'.test_package_cover()
		command! GoTestFile         lua require'nvim-go.test'.test_file()
		command! GoTestFileCover    lua require'nvim-go.test'.test_file_cover()
		command! GoTestFunc         lua require'nvim-go.test'.test_current_node()
		command! GoTestFuncCover    lua require'nvim-go.test'.test_current_node_cover()
		command! GoTest             lua require'nvim-go.test'.test_package()

		command! GoDef lua vim.lsp.buf.definition()
		command! GoRef lua vim.lsp.buf.references()
		command! GoImp lua vim.lsp.buf.implementation()

		command! GoDiagNext lua vim.diagnostic.goto_next()
		command! GoDiagPrev lua vim.diagnostic.goto_prev()
	]]
end

local function setup_vim_autocmds()
	vim.api.nvim_create_autocmd({"BufWritePre"}, {
		pattern = {"*.go"},
		callback = lsp.imports,
	})

	vim.api.nvim_create_autocmd({"BufWrite"}, {
		pattern = {"*.go", "go.mod", "go.sum"},
		callback = lsp.format,
	})
end

M.setup = function()
	setup_commands()
	setup_vim_autocmds()

	lsp.setupLspInstaller()
	-- warn if no LSP attached and we are in a Go file. Is LSP installed? Configured?
end

return M
