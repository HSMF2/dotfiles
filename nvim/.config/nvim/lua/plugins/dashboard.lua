local function apply_dashboard_highlights()
  vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#D0A9E5" })
  vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#E3D9D2" })
  vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#9AC47C" })
  vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#D9C18F" })
  vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = "#86B8C7" })
  vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", { fg = "#EE8A7A" })
end

local function pad_display_width(text, width)
  return text .. string.rep(" ", math.max(width - vim.fn.strdisplaywidth(text), 0))
end

local function center_display_width(text, width)
  local padding = math.max(width - vim.fn.strdisplaywidth(text), 0)
  local left = math.floor(padding / 2)
  return string.rep(" ", left) .. text .. string.rep(" ", padding - left)
end

local function dashboard_header()
  local art = {
    "  ██████   █████                   █████   █████  ███",
    " ░░██████ ░░███                   ░░███   ░░███  ░░░",
    "  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████",
    "  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███",
    "  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███",
    "  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███",
    "  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████",
    " ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░",
  }
  local width = 0
  for _, line in ipairs(art) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end
  for index, line in ipairs(art) do
    art[index] = pad_display_width(line, width)
  end
  table.insert(art, "")
  table.insert(art, center_display_width("λ it be like that sometimes λ", width))
  return table.concat(art, "\n")
end

return {
  {
    "folke/snacks.nvim",
    init = function()
      local group = vim.api.nvim_create_augroup("KittyDashboardHighlights", { clear = true })
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        group = group,
        callback = apply_dashboard_highlights,
      })
    end,
    opts = function(_, opts)
      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = opts.dashboard.preset or {}

      opts.dashboard.preset.header = dashboard_header()
      opts.dashboard.preset.keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        {
          icon = " ",
          key = "c",
          desc = "Config",
          action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
        },
        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      }

      opts.dashboard.sections = {
        { section = "header", padding = 2 },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      }
    end,
  },
}
