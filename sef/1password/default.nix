{ pkgs, inputs, ... }:
{
  programs = {
    ssh = {
      enable = true;
      matchBlocks."*" = {
        extraOptions = {
          IdentityAgent = "~/.1password/agent.sock";
        };
      };
    };
  };
  home.file.".config/1Password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    vault = "Private"

    [[ssh-keys]]
    vault = "NS"
  '';
}
