-- do formatting via lsp
local function format()
	vim.lsp.buf.formatting()
end

return {
	format = format
}
