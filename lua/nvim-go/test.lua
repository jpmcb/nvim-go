local core_ts = require'nvim-go.core.ts'
local health = require'nvim-go.healthcheck'

local M = {}

function M.test_all()
	local command = ':! go test ./...'
	vim.cmd(command)
end

function M.test_all_cover()
	if not health.is_cover_installed() then
		return
	end

	local tmp_file = os.tmpname()
	if not tmp_file then
		return
	end

	local test_command = ':! go test ./... -coverprofile=' .. tmp_file
	local serve_profile_command = ':! go tool cover -html=' .. tmp_file

	vim.cmd(test_command)
	vim.cmd(serve_profile_command)

	print("Coverage profile file generated to " .. tmp_file)
end

function M.test_package()
	local current_dir= vim.fn.expand('%:p:h')
	if not current_dir then
		return
	end

	local command = ':! go test ' .. current_dir
	vim.cmd(command)
end

function M.test_package_cover()
	if not health.is_cover_installed() then
		return
	end

	local tmp_file = os.tmpname()
	if not tmp_file then
		return
	end

	local current_dir = vim.fn.expand('%:p:h')
	if not current_dir then
		return
	end

	local command = ':! go test ' .. current_dir .. ' -coverprofile=' .. tmp_file
	local serve_profile_command = ':! go tool cover -html=' .. tmp_file

	vim.cmd(command)
	vim.cmd(serve_profile_command)

	print("Coverage profile file generated to " .. tmp_file)
end

function M.test_file()
	local current_dir = vim.fn.expand('%:p:h')
	if not current_dir then
		return
	end

	local funcs = core_ts.get_functions_in_file()
	local funcs_regex =  ''

	for _, v in ipairs(funcs) do
		funcs_regex = funcs_regex .. v .. '|'
	end
	funcs_regex = funcs_regex:sub(1, -2)
	if not funcs_regex then
		return
	end

	local command = ':! go test ' .. current_dir .. ' -run "' .. funcs_regex .. '"'
	vim.cmd(command)
end

function M.test_file_cover()
	local current_dir = vim.fn.expand('%:p:h')
	if not current_dir then
		return
	end

	local tmp_file = os.tmpname()
	if not tmp_file then
		return
	end

	local funcs = core_ts.get_functions_in_file()
	local funcs_regex =  ''

	for _, v in ipairs(funcs) do
		funcs_regex = funcs_regex .. v .. '|'
	end

	funcs_regex = funcs_regex:sub(1, -2)
	if not funcs_regex then
		return
	end

	local command = ':! go test ' .. current_dir .. ' -run "' .. funcs_regex .. '" -coverprofile=' .. tmp_file
	local serve_profile_command = ':! go tool cover -html=' .. tmp_file

	vim.cmd(command)
	vim.cmd(serve_profile_command)
end

function M.test_pattern()
end

function M.test_pattern_cover()
end

function M.test_current_node()
	local func_name = core_ts.get_function_name_at_cursor()
	if not func_name then
		return
	end

	local current_dir= vim.fn.expand('%:p:h')
	local command = ':! go test ' .. current_dir .. ' -run ' .. func_name

	vim.cmd(command)
end

function M.test_current_node_cover()
	local func_name = core_ts.get_function_name_at_cursor()
	if not func_name then
		return
	end

	local current_dir= vim.fn.expand('%:p:h')
	if not current_dir then
		return
	end

	local tmp_file = os.tmpname()
	if not tmp_file then
		return
	end

	local command = ':! go test ' .. current_dir .. ' -run ' .. func_name
	local serve_profile_command = ':! go tool cover -html=/tmp/cover-package.out'

	vim.cmd(command)
	vim.cmd(serve_profile_command)
end

return M
