{ inputs, ... }:
{

  home.file.".config/ghostty/config".text = ''
    background-opacity = 0.9
    background-blur-radius = 20

    font-family = Fantasque Sans Mono
    window-decoration = false
    confirm-close-surface = false

    adjust-cell-height = 35%
    adjust-cursor-height = 35%
    font-size = 11

    keybind = alt+h=goto_split:left
    keybind = alt+j=goto_split:bottom
    keybind = alt+k=goto_split:top
    keybind = alt+l=goto_split:right

    keybind = ctrl+space>h=new_split:left
    keybind = ctrl+space>j=new_split:down
    keybind = ctrl+space>k=new_split:up
    keybind = ctrl+space>l=new_split:right

    keybind = ctrl+space>f=toggle_split_zoom

    keybind = ctrl+space>r=reload_config

    keybind = ctrl+space>t=new_tab
    keybind = ctrl+space>g=toggle_tab_overview
    keybind = ctrl+space>n=next_tab
    keybind = ctrl+space>p=previous_tab

    keybind = ctrl+space>one=goto_tab:1
    keybind = ctrl+space>two=goto_tab:2
    keybind = ctrl+space>three=goto_tab:3
    keybind = ctrl+space>four=goto_tab:4
    keybind = ctrl+space>five=goto_tab:5
    keybind = ctrl+space>six=goto_tab:6
    keybind = ctrl+space>seven=goto_tab:7
    keybind = ctrl+space>eight=goto_tab:8
    keybind = ctrl+space>nine=goto_tab:9
    keybind = ctrl+space>zero=goto_tab:10

    window-save-state = always
  '';
}
