{ pkgs
, config
, ...
}:
{
  environment.systemPackages = with pkgs; [
    htop
  ];
} 
