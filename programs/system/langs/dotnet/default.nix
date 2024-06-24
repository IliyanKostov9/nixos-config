{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
    dotnetCorePackages.sdk_8_0_1xx
  ];
}
