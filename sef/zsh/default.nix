{ pkgs, inputs, ... }:
{
  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cat = "bat";
      cd = "z";
      v = "nvim";
    };
    envExtra = ''
      ZELLIJ_AUTO_ATTACH="true";
      PATH="$PATH:$HOME/.cache/.bun/bin";
      PATH="$PATH:$HOME/bin";
      LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/run/opengl-driver/lib:/run/opengl-driver-32/lib"
    '';
  };
}
