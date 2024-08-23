{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    fzf
    ripgrep
    fd
  ];
}
