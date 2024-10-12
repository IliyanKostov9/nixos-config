{ pkgs, users, ... }:

{
  # REQUIRED: for initialHashedPassword
  users.mutableUsers = false;
  users.users = builtins.mapAttrs
    (_: user-attr: {
      inherit (user-attr) isNormalUser description extraGroups initialHashedPassword createHome;
      shell = pkgs.zsh;
    }
    )
    users;
}
