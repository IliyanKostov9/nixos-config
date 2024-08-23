{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    xclip
  ];
}
