-- TODO: make build tags configurable for user
local function getBuildTags()
	return ''
end

-- TODO: Sharp UX. No way to know if it was successful
local function build()
	local command = ':! go build'
	local tags = getBuildTags()

	if tags ~= '' then
		command = command .. ' -tags ' .. tags
	end

	vim.cmd(command)
end


return {
	build = build
}
