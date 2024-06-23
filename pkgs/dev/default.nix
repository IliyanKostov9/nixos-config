{ pkgs
, config
, ...
}:
{
  imports = [ ./git ./build-tools/sdkmanager ];
}
