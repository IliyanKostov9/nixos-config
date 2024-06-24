{ pkgs
, config
, ...
}:
{
  imports = [ ./awscli ./rclone ./azure-cli ];
}
