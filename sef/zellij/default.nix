{ pkgs, inputs, ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };
  home.file.".config/zellij/config.kdl".text = builtins.readFile ./config.kdl;
  home.file.".config/zellij/layouts/default.kdl".text = ''
    layout {
      default_tab_template {
        pane size=1 borderless=true {
          plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
            format_left " #[fg=green]{session} {mode} {swap_layout}"
            format_center "{tabs}"
            format_right "{command_git_branch} "
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

            command_git_branch_command "git rev-parse --abbrev-ref HEAD"
            command_git_branch_format "#[fg=blue] {stdout} "
            command_git_branch_interval "5"
            command_git_branch_rendermode "static"

            datetime "#[fg=blue,bold] {format} "
            datetime_format "%A, %d %b %Y %H:%M"
            datetime_timezone "Europe/Amsterdam"
          }
        }
        children
      }
    }
  '';
}
