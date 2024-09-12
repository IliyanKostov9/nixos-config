{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ ansible ];
}
