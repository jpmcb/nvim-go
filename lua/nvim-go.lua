local fmt = require "nvim-go.format"
local imp = require "nvim-go.imports"
local bld = require "nvim-go.build"

local Plugin = {}

local function setup_vim_commands()
	vim.cmd [[
		command! GoRename  lua require'nvim-go.rename'.rename()
		command! GoFmt     lua require'nvim-go.format'.format()
		command! GoImports lua require'nvim-go.imports'.imports()
		command! GoBuild   lua require'nvim-go.build'.build()

		command! GoDef lua vim.lsp.buf.definition()
		command! GoRef lua vim.lsp.buf.references()
		command! GoImp lua vim.lsp.buf.implementation()

		command! GoDiagNext lua vim.diagnostic.goto_next()
		command! GoDiagPrev lua vim.diagnostic.goto_prev()
	]]
end

local function setup_vim_autocmds()
	-- on pre-write, format using LSP
	vim.api.nvim_create_autocmd({"BufWrite"}, {
		pattern = {"*.go", "go.mod", "go.sum"},
		callback = fmt.format,
	})

	vim.api.nvim_create_autocmd({"BufWritePre"}, {
		pattern = {"*.go"},
		callback = imp.imports,
	})
end

function Plugin.setup()
	setup_vim_commands()
	setup_vim_autocmds()
end

return Plugin
