{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics.enable = true;
    graphics.extraPackages = [ pkgs.libGL ];
    graphics.enable32Bit = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "565.77";
        sha256_32bit = lib.fakeHash;
        sha256_64bit = "sha256-CnqnQsRrzzTXZpgkAtF7PbH9s7wbiTRNcM0SPByzFHw=";
        settingsSha256 = "sha256-CnqnQsRrzzTXZpgkAtF7PbH9s7wbiTRNcM0SPByzFHw=";
        sha256_aarch64 = lib.fakeHash;
        openSha256 = lib.fakeHash;
        persistencedSha256 = "sha256-wnDjC099D8d9NJSp9D0CbsL+vfHXyJFYYgU3CwcqKww=";
      };
      nvidiaPersistenced = true;
    };
  };
  boot.extraModprobeConfig =
    "options nvidia "
    + pkgs.lib.concatStringsSep " " [
      # nvidia assume that by default your CPU does not support PAT,
      # but this is effectively never the case in 2023
      "NVreg_UsePageAttributeTable=1"
      "NVreg_PreserveVideoMemoryAllocations=1"
      "NVreg_TemporaryFilePath=/var/tmp"
      # This may be a noop, but it's somewhat uncertain
      "NVreg_EnablePCIeGen3=1"
      # This is sometimes needed for ddc/ci support, see
      # https://www.ddcutil.com/nvidia/
      #
      # Current monitor does not support it, but this is useful for
      # the future
      "NVreg_RegistryDwords=RMUseSwI2c=0x01;RMI2cSpeed=100"
    ];
}
