{
    pkgs,
	...
}:
{
	home.file.".config/nvim/init.lua".source = ./init.lua;
    home.file.".config/nvim/after/ftplugin/lua.lua".source = ../nixvim/after/ftplugin/lua.lua;
    home.file.".config/nvim/after/ftplugin/nix.lua".source = ../nixvim/after/ftplugin/nix.lua;

    home.packages = with pkgs; [
        # compiling nvim
        gnumake
        cmake
        gcc
        gettext

        # gleam
        gleam
        erlang
        rebar3

        # lua
        lua-language-server
        stylua

        # telescope media-files
        chafa
        imagemagick
        ffmpegthumbnailer
        poppler_utils

        # nix
        nil
        nixfmt-rfc-style

        # typescript / deno
        bun
        deno
        nodejs_23
        yarn
        typescript-language-server

        # go
        go
        gopls
        templ
    ];
}
