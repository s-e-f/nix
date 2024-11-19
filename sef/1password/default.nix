{ ... }:
{
  programs = {
    ssh.extraConfig = ''
      IdentityAgent ~/.1password/agent.sock
    '';
    ssh.matchBlocks."github.com".extraOptions.IdentityAgent = "~/.1password/agent.sock";
  };
  home.file.".config/1Password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    vault = "Private"
  '';
}
