{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ pcmanfm ];
}
