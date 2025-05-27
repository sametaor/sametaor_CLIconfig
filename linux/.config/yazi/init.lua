require("git"):setup()
require("full-border"):setup()
if os.getenv("NVIM") then
	require("hide-preview"):entry()
end
Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)
Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	})
end, 500, Status.RIGHT)
require("restore"):setup({
	-- Set the position for confirm and overwrite dialogs.
	-- don't forget to set height: `h = xx`
	-- https://yazi-rs.github.io/docs/plugins/utils/#ya.input
	position = { "center", w = 70, h = 40 },

	-- Show confirm dialog before restore.
	-- NOTE: even if set this to false, overwrite dialog still pop up
	show_confirm = true,

	-- colors for confirm and overwrite dialogs
	theme = {
		title = "blue",
		header = "green",
		-- header color for overwrite dialog
		header_warning = "yellow",
		list_item = { odd = "blue", even = "blue" },
	},
})
require("omp"):setup({
	config = "https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/refs/heads/master/misc/sametaor.omp.json",
})
