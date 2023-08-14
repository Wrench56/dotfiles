local status, image = pcall(require, 'image')
if (not status) then return end

image.setup {
   render = {
    min_padding = 5,
    show_label = true,
	show_image_dimensions = true,
    use_dither = false,
    foreground_color = true,
    background_color = true
  },
  events = {
    update_on_nvim_resize = true,
  }
}
