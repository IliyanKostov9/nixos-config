{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ git ];
} 
