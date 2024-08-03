{ config, lib, pkgs, users, ... }:

{
  users.users = builtins.mapAttrs
    (user: user-attr: {
      inherit (user-attr) isNormalUser description extraGroups;
      shell = pkgs.zsh;
    }
    )
    users;
}
