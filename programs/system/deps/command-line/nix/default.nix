{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
    # nix-update
    nix-output-monitor
    comma
  ];
}
