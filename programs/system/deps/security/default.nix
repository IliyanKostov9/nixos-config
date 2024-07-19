{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ openssl pass docker-credential-helpers ];
}
