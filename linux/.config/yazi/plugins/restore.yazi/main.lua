--- @since 25.2.7

local M = {}
local shell = os.getenv("SHELL") or ""
local PackageName = "Restore"
local function success(s, ...)
	ya.notify({ title = PackageName, content = string.format(s, ...), timeout = 5, level = "info" })
end

local function fail(s, ...)
	ya.notify({ title = PackageName, content = string.format(s, ...), timeout = 5, level = "error" })
end

---@enum STATE
local STATE = {
	POSITION = "position",
	SHOW_CONFIRM = "show_confirm",
	THEME = "theme",
}

local set_state = ya.sync(function(state, key, value)
	if state then
		state[key] = value
	else
		state = {}
		state[key] = value
	end
end)

local get_state = ya.sync(function(state, key)
	if state then
		return state[key]
	else
		return nil
	end
end)

---@enum File_Type
local File_Type = {
	File = "file",
	Dir = "dir_all",
	None_Exist = "unknown",
}

---@alias TRASHED_ITEM {trash_index: number, trashed_date_time: string, trashed_path: string, type: File_Type} Item in trash list

function get_basename(filepath)
	return filepath:match("^.+/(.+)$") or filepath
end

local get_cwd = ya.sync(function()
	return tostring(cx.active.current.cwd)
end)

local function path_quote(path)
	local result = "'" .. string.gsub(path, "'", "'\\''") .. "'"
	return result
end

local function get_file_type(path)
	local cha, _ = fs.cha(Url(path))
	if cha then
		return cha.is_dir and File_Type.Dir or File_Type.File
	else
		return File_Type.None_Exist
	end
end

local function get_trash_volume()
	local cwd = get_cwd()
	local trash_volumes_stream, cmr_err =
		Command("trash-list"):args({ "--volumes" }):stdout(Command.PIPED):stderr(Command.PIPED):output()

	local matched_vol_path = nil
	if trash_volumes_stream then
		local matched_vol_length = 0
		for vol in trash_volumes_stream.stdout:gmatch("[^\r\n]+") do
			local vol_length = utf8.len(vol) or 0
			if cwd:sub(1, vol_length) == vol and vol_length > matched_vol_length then
				matched_vol_path = vol
				matched_vol_length = vol_length
			end
		end
		if not matched_vol_path then
			fail("Can't get trash directory")
		end
	else
		fail("Failed to start `trash-list` with error: `%s`. Do you have `trash-cli` installed?", cmr_err)
	end
	return matched_vol_path
end

---get list of latest files/folders trashed
---@param curr_working_volume currently working volume
---@return TRASHED_ITEM[]|nil
local function get_latest_trashed_items(curr_working_volume)
	---@type TRASHED_ITEM[]
	local restorable_items = {}
	local fake_enter = Command("printf"):stderr(Command.PIPED):stdout(Command.PIPED):spawn():take_stdout()
	local trash_list_stream, err_cmd = Command(shell)
		:args({ "-c", "trash-restore " .. path_quote(curr_working_volume) })
		:stdin(fake_enter)
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	if trash_list_stream then
		---@type TRASHED_ITEM[]
		local trash_list = {}
		for line in trash_list_stream.stdout:gmatch("[^\r\n]+") do
			-- remove leading spaces
			line = line:match("^%s*(.+)$")
			local trash_index, item_date, item_path = line:match("^(%d+) (%S+ %S+) (.+)$")
			if item_date and item_path and trash_index ~= nil then
				table.insert(trash_list, {
					trash_index = tonumber(trash_index),
					trashed_date_time = item_date,
					trashed_path = item_path,
					type = File_Type.None_Exist,
				})
			end
		end

		if #trash_list == 0 then
			success("Nothing left to restore")
			return
		end

		local last_item_datetime = trash_list[#trash_list].trashed_date_time

		for _, trash_item in ipairs(trash_list) do
			if trash_item then
				if trash_item.trashed_date_time == last_item_datetime then
					trash_item.type = get_file_type(trash_item.trashed_path)
					table.insert(restorable_items, trash_item)
				end
			end
		end
	else
		fail("Failed to start `trash-restore` with error: `%s`. Do you have `trash-cli` installed?", err_cmd)
		return
	end
	return restorable_items
	-- return newest_trashed_items
end

---@param trash_list TRASHED_ITEM[]
local function filter_none_exised_paths(trash_list)
	---@type TRASHED_ITEM[]
	local existed_trash_items = {}
	for _, v in ipairs(trash_list) do
		if v.type ~= File_Type.None_Exist then
			table.insert(existed_trash_items, v)
		end
	end
	return existed_trash_items
end

local function restore_files(curr_working_volume, start_index, end_index)
	if type(start_index) ~= "number" or type(end_index) ~= "number" or start_index < 0 or end_index < 0 then
		fail("Failed to restore file(s): out of range")
		return
	end

	ya.manager_emit("shell", {
		"echo " .. ya.quote(start_index .. "-" .. end_index) .. " | trash-restore --overwrite " .. path_quote(
			curr_working_volume
		),
		confirm = true,
	})
	local file_to_restore_count = end_index - start_index + 1
	success("Restored " .. tostring(file_to_restore_count) .. " file" .. (file_to_restore_count > 1 and "s" or ""))
end

function M:setup(opts)
	if opts and opts.position and type(opts.position) == "table" then
		set_state(STATE.POSITION, opts.position)
	else
		set_state(STATE.POSITION, { "center", w = 70, h = 40 })
	end
	if opts and opts.show_confirm then
		set_state(STATE.SHOW_CONFIRM, opts.show_confirm)
	else
		set_state(STATE.SHOW_CONFIRM, false)
	end
	if opts and opts.theme and type(opts.theme) == "table" then
		set_state(STATE.THEME, opts.theme)
	else
		set_state(STATE.THEME, {})
	end
end

---@param trash_list TRASHED_ITEM[]
local function get_components(trash_list)
	local theme = get_state(STATE.THEME) or {}
	theme.list_item = theme.list_item or {
		odd = "blue",
		even = "blue",
	}
	local trashed_items_components = {}
	for idx, item in pairs(trash_list) do
		local fg_color = theme.list_item.odd or "blue"
		if idx % 2 == 0 then
			fg_color = theme.list_item.even or "blue"
		end
		table.insert(
			trashed_items_components,
			ui.Line({
				ui.Span(" "),
				ui.Span(item.trashed_path):fg(fg_color),
			}):align(ui.Line.LEFT)
		)
	end
	return trashed_items_components
end

function M:entry()
	local curr_working_volume = get_trash_volume()
	if not curr_working_volume then
		return
	end
	local trashed_items = get_latest_trashed_items(curr_working_volume)
	if trashed_items == nil then
		return
	end
	local collided_items = filter_none_exised_paths(trashed_items)
	local overwrite_confirmed = true
	local show_confirm = get_state(STATE.SHOW_CONFIRM)
	local pos = get_state(STATE.POSITION)
	pos = pos or { "center", w = 70, h = 40 }

	local theme = get_state(STATE.THEME) or {}
	theme.title = theme.title or "blue"
	theme.header = theme.header or "green"
	theme.header_warning = theme.header_warning or "yellow"
	if ya.confirm and show_confirm then
		local continue_restore = ya.confirm({
			title = ui.Line("Restore files/folders"):fg(theme.title):bold(),
			content = ui.Text({
				ui.Line(""),
				ui.Line("The following files and folders are going to be restored:"):fg(theme.header),
				ui.Line(""),
				table.unpack(get_components(trashed_items)),
			})
				:align(ui.Text.LEFT)
				:wrap(ui.Text.WRAP),
			--TODO: still wating for API :/
			-- list = ui.List({
			-- 	table.unpack(get_components(trashed_items)),
			-- }),

			pos = pos,
		})
		-- stopping
		if not continue_restore then
			return
		end
	end

	-- show Confirm dialog with list of collided items
	if #collided_items > 0 then
		if ya.confirm then
			overwrite_confirmed = ya.confirm({
				title = ui.Line("Restore files/folders"):fg(theme.title):bold(),
				content = ui.Text({
					ui.Line(""),
					ui.Line("The following files and folders are existed, overwrite?"):fg(theme.header_warning),
					ui.Line(""),
					table.unpack(get_components(collided_items)),
				})
					:align(ui.Text.LEFT)
					:wrap(ui.Text.WRAP),
				pos = pos,
			})
		else
			-- TODO: Remove after v0.4.4 released
			local _, input_event = ya.input({
				title = "Overwrite the destination items?",
				value = #collided_items .. " files and folders existed.",
				position = pos,
			})
			overwrite_confirmed = input_event == 1
		end
	end
	if overwrite_confirmed then
		restore_files(curr_working_volume, trashed_items[1].trash_index, trashed_items[#trashed_items].trash_index)
	end
end

return M
