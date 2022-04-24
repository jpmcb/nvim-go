--[[

Need to execute healthcheck to ensure:

* go is installed
* At the root of a go.mod file
* gopls is installed and running
* go tools (gofmt etc.) installed

--]]

local M = {}

function M.is_cover_installed()
	return true
end

return M
