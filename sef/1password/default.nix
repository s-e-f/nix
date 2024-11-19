{ pkgs, inputs, ... }:
{
  programs = {
    ssh = {
      enable = true;
      extraConfig = ''
        IdentityAgent ~/.1password/agent.sock
      '';
      addKeysToAgent = "yes";
      compression = true;
      controlMaster = "auto";
      controlPath = "~/.ssh/control-%C";
      controlPersist = "300";
      matchBlocks."github.com" = {
        hostname = "ssh.github.com";
        port = 443;
        user = "git";
        extraOptions.IdentityAgent = "~/.1password/agent.sock";
      };
    };
  };
  home.file.".config/1Password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    vault = "Private"
  '';
}
