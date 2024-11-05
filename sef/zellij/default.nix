{
  pkgs,
  config,
  ...
}:
{
  stylix.targets.zellij.enable = false; # This prevents settings from being auto-generated
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = { };
  };
  home.file.".config/zellij/config.kdl".text = with config.lib.stylix.colors.withHashtag; ''
    // If you'd like to override the default keybindings completely, be sure to change "keybinds" to "keybinds clear-defaults=true"
    theme "stylix"
    themes {
      stylix {
        bg "${base03}"
        fg "${base05}"
        black "${base00}"
        blue "${base0D}"
        cyan "${base0C}"
        green "${base0B}"
        magenta "${base0E}"
        orange "${base09}"
        red "${base08}"
        white "${base07}"
        yellow "${base0A}"
      }
    }

    keybinds {
      unbind "Ctrl n" "Ctrl o" "Ctrl p" "Ctrl g" "Ctrl h" "Ctrl t" "Ctrl s" "Ctrl b" "Ctrl q"
        normal {
            // uncomment this and adjust key if using copy_on_select=false
            // bind "Alt c" { Copy; }
        }
        locked {
            bind "Alt l" { SwitchToMode "Normal"; }
        }
        resize {
            bind "Alt r" { SwitchToMode "Normal"; }
            bind "h" "Left" { Resize "Increase Left"; }
            bind "j" "Down" { Resize "Increase Down"; }
            bind "k" "Up" { Resize "Increase Up"; }
            bind "l" "Right" { Resize "Increase Right"; }
            bind "H" { Resize "Decrease Left"; }
            bind "J" { Resize "Decrease Down"; }
            bind "K" { Resize "Decrease Up"; }
            bind "L" { Resize "Decrease Right"; }
            bind "=" "+" { Resize "Increase"; }
            bind "-" { Resize "Decrease"; }
        }
        pane {
            bind "Alt p" { SwitchToMode "Normal"; }
            bind "h" "Left" { MoveFocus "Left"; }
            bind "l" "Right" { MoveFocus "Right"; }
            bind "j" "Down" { MoveFocus "Down"; }
            bind "k" "Up" { MoveFocus "Up"; }
            bind "p" { SwitchFocus; }
            bind "n" { NewPane; SwitchToMode "Normal"; }
            bind "d" { NewPane "Down"; SwitchToMode "Normal"; }
            bind "r" { NewPane "Right"; SwitchToMode "Normal"; }
            bind "x" { CloseFocus; SwitchToMode "Normal"; }
            bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
            bind "z" { TogglePaneFrames; SwitchToMode "Normal"; }
            bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
            bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
            bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0;}
        }
        move {
            bind "Alt m" { SwitchToMode "Normal"; }
            bind "n" "Tab" { MovePane; }
            bind "p" { MovePaneBackwards; }
            bind "h" "Left" { MovePane "Left"; }
            bind "j" "Down" { MovePane "Down"; }
            bind "k" "Up" { MovePane "Up"; }
            bind "l" "Right" { MovePane "Right"; }
        }
        tab {
            bind "Alt t" { SwitchToMode "Normal"; }
            bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
            bind "h" "Left" "Up" "k" { GoToPreviousTab; }
            bind "l" "Right" "Down" "j" { GoToNextTab; }
            bind "n" { NewTab; SwitchToMode "Normal"; }
            bind "x" { CloseTab; SwitchToMode "Normal"; }
            bind "s" { ToggleActiveSyncTab; SwitchToMode "Normal"; }
            bind "b" { BreakPane; SwitchToMode "Normal"; }
            bind "]" { BreakPaneRight; SwitchToMode "Normal"; }
            bind "[" { BreakPaneLeft; SwitchToMode "Normal"; }
            bind "1" { GoToTab 1; SwitchToMode "Normal"; }
            bind "2" { GoToTab 2; SwitchToMode "Normal"; }
            bind "3" { GoToTab 3; SwitchToMode "Normal"; }
            bind "4" { GoToTab 4; SwitchToMode "Normal"; }
            bind "5" { GoToTab 5; SwitchToMode "Normal"; }
            bind "6" { GoToTab 6; SwitchToMode "Normal"; }
            bind "7" { GoToTab 7; SwitchToMode "Normal"; }
            bind "8" { GoToTab 8; SwitchToMode "Normal"; }
            bind "9" { GoToTab 9; SwitchToMode "Normal"; }
            bind "Tab" { ToggleTab; }
        }
        scroll {
            bind "Alt o" { SwitchToMode "Normal"; }
            bind "e" { EditScrollback; SwitchToMode "Normal"; }
            bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
            bind "O" { ScrollToBottom; SwitchToMode "Normal"; }
            bind "j" "Down" { ScrollDown; }
            bind "k" "Up" { ScrollUp; }
            bind "Ctrl d" "PageDown" "Right" "l" { PageScrollDown; }
            bind "Ctrl u" "PageUp" "Left" "h" { PageScrollUp; }
            bind "d" { HalfPageScrollDown; }
            bind "u" { HalfPageScrollUp; }
            // uncomment this and adjust key if using copy_on_select=false
            // bind "Alt c" { Copy; }
        }
        search {
            bind "Alt o" { SwitchToMode "Normal"; }
            bind "O" { ScrollToBottom; SwitchToMode "Normal"; }
            bind "j" "Down" { ScrollDown; }
            bind "k" "Up" { ScrollUp; }
            bind "Ctrl d" "PageDown" "Right" "l" { PageScrollDown; }
            bind "Ctrl u" "PageUp" "Left" "h" { PageScrollUp; }
            bind "d" { HalfPageScrollDown; }
            bind "u" { HalfPageScrollUp; }
            bind "n" { Search "down"; }
            bind "p" { Search "up"; }
            bind "c" { SearchToggleOption "CaseSensitivity"; }
            bind "w" { SearchToggleOption "Wrap"; }
            bind "o" { SearchToggleOption "WholeWord"; }
        }
        entersearch {
            bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
            bind "Enter" { SwitchToMode "Search"; }
        }
        renametab {
            bind "Ctrl c" { SwitchToMode "Normal"; }
            bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
        }
        renamepane {
            bind "Ctrl c" { SwitchToMode "Normal"; }
            bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
        }
        session {
            bind "Alt w" { SwitchToMode "Normal"; }
            bind "Alt o" { SwitchToMode "Scroll"; }
            bind "d" { Detach; }
            bind "m" {
                LaunchOrFocusPlugin "session-manager" {
                    floating true
                    move_to_focused_tab true
                };
                SwitchToMode "Normal"
            }
        }
        tmux {
            bind "[" { SwitchToMode "Scroll"; }
            bind "Alt u" { Write 2; SwitchToMode "Normal"; }
            bind "\"" { NewPane "Down"; SwitchToMode "Normal"; }
            bind "%" { NewPane "Right"; SwitchToMode "Normal"; }
            bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
            bind "c" { NewTab; SwitchToMode "Normal"; }
            bind "," { SwitchToMode "RenameTab"; }
            bind "p" { GoToPreviousTab; SwitchToMode "Normal"; }
            bind "n" { GoToNextTab; SwitchToMode "Normal"; }
            bind "Left" { MoveFocus "Left"; SwitchToMode "Normal"; }
            bind "Right" { MoveFocus "Right"; SwitchToMode "Normal"; }
            bind "Down" { MoveFocus "Down"; SwitchToMode "Normal"; }
            bind "Up" { MoveFocus "Up"; SwitchToMode "Normal"; }
            bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
            bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
            bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
            bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
            bind "o" { FocusNextPane; }
            bind "d" { Detach; }
            bind "Space" { NextSwapLayout; }
            bind "x" { CloseFocus; SwitchToMode "Normal"; }
        }
        shared_except "locked" {
            bind "Alt l" { SwitchToMode "Locked"; }
            bind "Alt q" { Quit; }
            bind "Alt n" { NewPane; }
            bind "Alt i" { MoveTab "Left"; }
            bind "Alt s" { MoveTab "Right"; }
            bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
            bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
            bind "Alt j" "Alt Down" { MoveFocus "Down"; }
            bind "Alt k" "Alt Up" { MoveFocus "Up"; }
            bind "Alt =" "Alt +" { Resize "Increase"; }
            bind "Alt -" { Resize "Decrease"; }
            bind "Alt [" { PreviousSwapLayout; }
            bind "Alt ]" { NextSwapLayout; }
        }
        shared_except "normal" "locked" {
            bind "Enter" "Esc" { SwitchToMode "Normal"; }
        }
        shared_except "pane" "locked" {
            bind "Alt p" { SwitchToMode "Pane"; }
        }
        shared_except "resize" "locked" {
            bind "Alt r" { SwitchToMode "Resize"; }
        }
        shared_except "scroll" "locked" {
            bind "Alt o" { SwitchToMode "Scroll"; }
        }
        shared_except "session" "locked" {
            bind "Alt w" { SwitchToMode "Session"; }
        }
        shared_except "tab" "locked" {
            bind "Alt t" { SwitchToMode "Tab"; }
        }
        shared_except "move" "locked" {
            bind "Alt m" { SwitchToMode "Move"; }
        }
        shared_except "tmux" "locked" {
            bind "Alt u" { SwitchToMode "Tmux"; }
        }
    }

    plugins {
        tab-bar location="zellij:tab-bar"
        status-bar location="zellij:status-bar"
        strider location="zellij:strider"
        compact-bar location="zellij:compact-bar"
        session-manager location="zellij:session-manager"
        welcome-screen location="zellij:session-manager" {
            welcome_screen true
        }
        filepicker location="zellij:strider" {
            cwd "/"
        }
    }

    pane_frames false

  '';
  home.file.".config/zellij/layouts/default.kdl".text = ''
    layout {
      default_tab_template {
        pane size=1 borderless=true {
          plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
            format_left "{mode} {swap_layout}"
            format_center "{tabs}"
            format_right "#[fg=green]{session} "
            format_space ""

            border_enabled "false"
            border_char "-"
            border_format "#[fg=green]{char}"
            border_position "top"

            hide_frame_for_single_pane "false"

            mode_normal "#[fg=black,bg=green] {name} "
            mode_locked "#[fg=black,bg=red] {name} "
            mode_resize "#[fg=black,bg=yellow] {name} "
            mode_pane "#[fg=black,bg=blue] {name} "
            mode_tab "#[fg=black,bg=blue] {name} "
            mode_scroll "#[fg=black,bg=magenta] {name} "
            mode_enter_search "#[fg=black,bg=green] {name} "
            mode_search "#[fg=black,bg=green] {name} "
            mode_rename_tab "#[fg=black,bg=yellow] {name} "
            mode_rename_pane "#[fg=black,bg=yellow] {name} "
            mode_session "#[fg=black,bg=blue] {name} "
            mode_move "#[fg=black,bg=yellow] {name} "
            mode_prompt "#[fg=black,bg=yellow] {name} "
            mode_tmux "#[fg=black,bg=red] {name} "

            tab_normal "#[fg=white]{name}"
            tab_active "#[fg=blue,bold]{name}"
            tab_separator "  "

            datetime "#[fg=blue,bold] {format} "
            datetime_format "%A, %d %b %Y %H:%M"
            datetime_timezone "Europe/Amsterdam"
          }
        }
        children
      }
      swap_floating_layout {
        floating_panes max_panes=1 {
          pane x="5%" width="90%" y="5%" height="90%"
        }
      }
    }
  '';
}
