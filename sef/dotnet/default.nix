{
  ...
}:
{
  # Install dotnet manually into the home folder to allow tool and workload installations to work
  programs.zsh.envExtra = ''
    export DOTNET_ROOT="$HOME/.dotnet"
    export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT="1"
    export DOTNET_CLI_TELEMETRY_OPTOUT="1"
    export DOTNET_SKIP_FIRST_TIME_EXPERIENCE="true"
    export PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools"
  '';
}
