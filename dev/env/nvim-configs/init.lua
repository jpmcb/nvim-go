require('packer').startup(function()
	-- necessary packages for lsp to be up and configured
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	use 'nvim-treesitter/nvim-treesitter'

	-- This projects Go client
	 use 'jpmcb/nvim-go'
end)

require('nvim-go').setup()

