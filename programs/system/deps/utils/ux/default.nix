{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    tree
    eza
  ];
}
