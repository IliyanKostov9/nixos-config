{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
    kotlin
  ];
} 
