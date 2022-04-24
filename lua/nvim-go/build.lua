local M = {}

-- TODO: make build tags configurable for user
local function getBuildTags()
	return ''
end

-- TODO: Sharp UX. No way to know if it was successful
function M.build()
	local command = ':! go build'
	local tags = getBuildTags()

	if tags ~= '' then
		command = command .. ' -tags ' .. tags
	end

	vim.cmd(command)
end

function M.install()
	local command = ':! go install'
	vim.cmd(command)
end

-- Create and serve a coverage profile
-- Command to "refactor into function"

return M
