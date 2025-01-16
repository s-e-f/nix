{
  pkgs,
  ...
}:
{
  # Install dotnet manually into the home folder to allow tool and workload installations to work
  programs.zsh.envExtra = ''
    export DOTNET_ROOT="$HOME/.dotnet"
    export DOTNET_CLI_TELEMETRY_OPTOUT="1"
    export DOTNET_SKIP_FIRST_TIME_EXPERIENCE="true"
    export PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools"
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.icu}/lib:${pkgs.openssl}/lib"
    export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive";
  '';
}
