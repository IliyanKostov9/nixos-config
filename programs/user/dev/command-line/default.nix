{ pkgs
, config
, ...
}:
{
  imports = [ ./sdkmanager ./sops ./gnupg ];
}
