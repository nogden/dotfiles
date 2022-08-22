local term = require 'wezterm'
return {
  -- Ui
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  color_scheme = 'Darkside',
  -- Disable ligatures that obfuscate code
  harfbuzz_features = { 'calt=0' },

  -- Keyboard bindings
  keys = {
    { key = 'F11', action = term.action.ToggleFullScreen }
  } 
}
