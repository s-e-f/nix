{ ... }:
{
  programs = {
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      compression = true;
      controlMaster = "auto";
      controlPath = "~/.ssh/control-%C";
      controlPersist = "300";
      matchBlocks."github.com" = {
        hostname = "ssh.github.com";
        port = 443;
        user = "git";
      };
    };
  };
}
