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
    };
  };
}
