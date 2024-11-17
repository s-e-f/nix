{
  pkgs,
  config,
  inputs,
  ...
}:
let
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHdwEkINsn9b0Uyct8TMobD1959B3jzxyVZ0+QPPFdyQ";
  email = "39380372+s-e-f@users.noreply.github.com";
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = email;
    userName = "Sef";
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        navigate = true;
      };
    };
    extraConfig = {
      core.sshCommand = "ssh";
      commit.gpgsign = true;
      credential = {
        cacheOptions = "--timeout 21600";
        credentialStore = "secretservice";
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
        useHttpPath = true;
      };
      diff.colorMoved = "default";
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      pull.rebase = true;
      tag.gpgsign = true;
      rerere = {
        enabled = true;
      };
      status = {
        showUntrackedFiles = "all";
        relativePaths = false;
      };
      user.signingkey = public_key;
    };
    aliases = {
      st = "status -sb";
      lg = "log --color --graph --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };
}
