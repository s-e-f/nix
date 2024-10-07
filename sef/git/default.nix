{ pkgs, inputs, ... }:
let
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWzfajaOsrjRi9VBZ1eZHndHr/8HoIZT6szzySUVHAF";
  email = "39380372+s-e-f@users.noreply.github.com";
in
{
  home.packages = with pkgs; [ git-credential-manager ];
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = email;
    userName = "Sef";
    delta = {
      enable = true;
      options = {
        "side-by-side" = true;
      };
    };
    extraConfig = {
      core.sshCommand = "ssh";
      commit.gpgsign = true;
      diff.colorMoved = "default";
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        ssh.program = "op-ssh-sign";
      };
      credential.credentialStore = "secretservice";
      credential.cacheOptions = "--timeout 21600";
      credential.useHttpPath = true;
      credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      init.defaultBranch = "main";
      log.showSignature = true;
      merge.conflictstyle = "diff3";
      tag.gpgsign = true;
      user.signingkey = public_key;
      status = {
        showUntrackedFiles = "all";
        relativePaths = false;
      };
    };
    aliases = {
      st = "status -sb";
      prbi = "pull --rebase=interactive";
      prb = "pull --rebase";
    };
  };
}
