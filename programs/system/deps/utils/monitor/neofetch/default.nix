{ pkgs
, config
, ...
}:
{
  environment.systemPackages = with pkgs; [
    neofetch
  ];
} 
