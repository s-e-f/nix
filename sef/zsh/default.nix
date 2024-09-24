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
      PATH="$PATH:/usr/share/dotnet";
      PATH="$PATH:$HOME/.dotnet/tools";
      DOTNET_ROOT="/usr/share/dotnet";
    '';
  };
}
