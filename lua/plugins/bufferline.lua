-- bufferline (tabs)

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local bufferline = prequire('bufferline')
if not bufferline then
  return
end

bufferline.setup({
  options = {
    mode = "buffers",
    separator_style = "thin",
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    color_icons = true,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close' },
    },
  },
})
