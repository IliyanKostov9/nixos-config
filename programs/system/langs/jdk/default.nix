{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
    jdk19
  ];
} 
