{ pkgs, inputs, ... }:
let
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWzfajaOsrjRi9VBZ1eZHndHr/8HoIZT6szzySUVHAF";
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
        features = "kanagawa";
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
        ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      };
      init.defaultBranch = "main";
      log.showSignature = true;
      merge.conflictstyle = "diff3";
      tag.gpgsign = true;
      user.signingkey = public_key;
      status = {
        showUntrackedFiles = "all";
        relativePaths = false;
      };
      delta.syntax-theme = "kanagawa";
    };
    aliases = {
      st = "status -sb";
      prbi = "pull --rebase=interactive";
      prb = "pull --rebase";
    };
  };
}
