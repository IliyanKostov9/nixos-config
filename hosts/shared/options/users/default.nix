{ pkgs, users, ... }:

{
  users.mutableUsers = false;
  users.users = builtins.mapAttrs
    (_: user-attr: {
      inherit (user-attr) isNormalUser description extraGroups initialHashedPassword;
      shell = pkgs.zsh;
    }
    )
    users;
}
