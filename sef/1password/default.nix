{ pkgs, inputs, ... }:
{
  programs = {
    ssh = {
      enable = true;
      matchBlocks."github.com" = {
        hostname = "ssh.github.com";
        port = 443;
        user = "git";
        extraOptions.IdentityAgent = "~/.1password/agent.sock";
      };
      matchBlocks."*" = {
        extraOptions.IdentityAgent = "~/.1password/agent.sock";
      };
    };
  };
  home.file.".config/1Password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    vault = "Private"
  '';
}
