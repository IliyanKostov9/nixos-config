{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [sqlite];
}
