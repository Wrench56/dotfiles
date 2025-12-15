config.load_autoconfig(False)

# Configs

config.set('content.javascript.clipboard', 'access-paste')

c.scrolling.smooth = True
c.auto_save.session = True
c.zoom.default = '100%'
c.url.start_pages = ['file:///usr/local/share/browser_homepage/index.html']
c.url.searchengines = {'DEFAULT': 'https://google.com/search?q={}'}

c.downloads.location.directory = '~/downloads'
c.downloads.location.prompt = False

c.fonts.default_size = '12pt'

# Security
c.content.cookies.accept = 'no-3rdparty'
c.content.webrtc_ip_handling_policy = 'default-public-interface-only'
c.content.geolocation = False
c.content.javascript.clipboard = 'access-paste'
c.content.local_content_can_access_remote_urls = True
config.set("content.cookies.accept", "all", "file://")

# Font
c.fonts.default_family = "Hack Nerd"

# Theme

# credits to theova/base16-qutebrowser for the original template
# credits to leandwo/qutebrowser-themes for the onedark theme

bg_default = '#282c34'
bg_lighter = '#353b45'
bg_selection = '#3e4451'
fg_disabled = '#565c64'
fg_default = '#abb2bf'
bg_lightest = '#c8ccd4'
fg_error = '#e06c75'
bg_hint = '#e5c07b'
fg_matched_text = '#98c379'
bg_passthrough_mode = '#56b6c2'
bg_insert_mode = '#61afef'
bg_warning = '#c678dd'

c.colors.completion.fg = fg_default
c.colors.completion.odd.bg = bg_lighter
c.colors.completion.even.bg = bg_default
c.colors.completion.category.fg = bg_hint
c.colors.completion.category.bg = bg_default
c.colors.completion.category.border.top = bg_default
c.colors.completion.category.border.bottom = bg_default
c.colors.completion.item.selected.fg = fg_default
c.colors.completion.item.selected.bg = bg_selection
c.colors.completion.item.selected.border.top = bg_selection
c.colors.completion.item.selected.border.bottom = bg_selection
c.colors.completion.item.selected.match.fg = fg_matched_text
c.colors.completion.match.fg = fg_matched_text
c.colors.completion.scrollbar.fg = fg_default
c.colors.completion.scrollbar.bg = bg_default
c.colors.contextmenu.disabled.bg = bg_lighter
c.colors.contextmenu.disabled.fg = fg_disabled
c.colors.contextmenu.menu.bg = bg_default
c.colors.contextmenu.menu.fg = fg_default
c.colors.contextmenu.selected.bg = bg_selection
c.colors.contextmenu.selected.fg = fg_default
c.colors.downloads.bar.bg = bg_default
c.colors.downloads.start.fg = bg_default
c.colors.downloads.start.bg = bg_insert_mode
c.colors.downloads.stop.fg = bg_default
c.colors.downloads.stop.bg = bg_passthrough_mode
c.colors.downloads.error.fg = fg_error
c.colors.hints.bg = bg_hint
c.colors.hints.match.fg = fg_default
c.colors.keyhint.fg = fg_default
c.colors.keyhint.suffix.fg = fg_default
c.colors.keyhint.bg = bg_default
c.colors.messages.error.fg = bg_default
c.colors.messages.error.bg = fg_error
c.colors.messages.error.border = fg_error
c.colors.messages.warning.fg = bg_default
c.colors.messages.warning.bg = bg_warning
c.colors.messages.warning.border = bg_warning
c.colors.messages.info.fg = fg_default
c.colors.messages.info.bg = bg_default
c.colors.messages.info.border = bg_default
c.colors.prompts.fg = fg_default
c.colors.prompts.border = bg_default
c.colors.prompts.bg = bg_default
c.colors.prompts.selected.bg = bg_selection
c.colors.prompts.selected.fg = fg_default
c.colors.statusbar.normal.fg = fg_matched_text
c.colors.statusbar.normal.bg = bg_default
c.colors.statusbar.insert.fg = bg_default
c.colors.statusbar.insert.bg = bg_insert_mode
c.colors.statusbar.passthrough.fg = bg_default
c.colors.statusbar.passthrough.bg = bg_passthrough_mode
c.colors.statusbar.private.fg = bg_default
c.colors.statusbar.private.bg = bg_lighter
c.colors.statusbar.command.fg = fg_default
c.colors.statusbar.command.bg = bg_default
c.colors.statusbar.command.private.fg = fg_default
c.colors.statusbar.command.private.bg = bg_default
c.colors.statusbar.caret.fg = bg_default
c.colors.statusbar.caret.bg = bg_warning
c.colors.statusbar.caret.selection.fg = bg_default
c.colors.statusbar.caret.selection.bg = bg_insert_mode
c.colors.statusbar.progress.bg = bg_insert_mode
c.colors.statusbar.url.fg = fg_default
c.colors.statusbar.url.error.fg = fg_error
c.colors.statusbar.url.hover.fg = fg_default
c.colors.statusbar.url.success.http.fg = bg_passthrough_mode
c.colors.statusbar.url.success.https.fg = fg_matched_text
c.colors.statusbar.url.warn.fg = bg_warning
c.colors.tabs.bar.bg = bg_default
c.colors.tabs.indicator.start = bg_insert_mode
c.colors.tabs.indicator.stop = bg_passthrough_mode
c.colors.tabs.indicator.error = fg_error
c.colors.tabs.odd.fg = fg_default
c.colors.tabs.odd.bg = bg_lighter
c.colors.tabs.even.fg = fg_default
c.colors.tabs.even.bg = bg_default
c.colors.tabs.pinned.even.bg = bg_passthrough_mode
c.colors.tabs.pinned.even.fg = bg_lightest
c.colors.tabs.pinned.odd.bg = fg_matched_text
c.colors.tabs.pinned.odd.fg = bg_lightest
c.colors.tabs.pinned.selected.even.bg = bg_selection
c.colors.tabs.pinned.selected.even.fg = fg_default
c.colors.tabs.pinned.selected.odd.bg = bg_selection
c.colors.tabs.pinned.selected.odd.fg = fg_default
c.colors.tabs.selected.odd.fg = fg_default
c.colors.tabs.selected.odd.bg = bg_selection
c.colors.tabs.selected.even.fg = fg_default
c.colors.tabs.selected.even.bg = bg_selection
