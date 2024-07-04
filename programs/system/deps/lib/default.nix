{ pkgs
, config
, ...
}:

{
  programs.nix-ld.libraries = with pkgs; [
    steam-run
  ];
}
