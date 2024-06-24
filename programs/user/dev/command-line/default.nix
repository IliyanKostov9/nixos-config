{ pkgs
, config
, ...
}:
{
  imports = [ ./sdkmanager ./sops ./gnupg ./pinetry-qt ];
}
