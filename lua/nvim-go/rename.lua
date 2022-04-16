local function rename()
	vim.lsp.buf.rename()
end

return {
	rename = rename
}
