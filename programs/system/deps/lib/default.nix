{ pkgs
, config
, ...
}:

{
  programs.nix-ld.libraries = with pkgs; [
    steam-run # Needed for MarkdownPreview Neovim to run
  ];
}
