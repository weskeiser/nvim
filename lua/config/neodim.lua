require("neodim").setup({
  alpha = 0.75,
  blend_color = "#000000",
  update_in_insert = {
    enable = true,
    delay = 500,
  },
  hide = {
    virtual_text = true,
    signs = false,
    underline = true,
  }
})
