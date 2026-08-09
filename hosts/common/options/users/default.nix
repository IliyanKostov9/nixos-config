{
  pkgs,
  users,
  ...
}: let
  defaultShell = "zsh";
in {
  users = {
    # NOTE: REQUIRED: for initialHashedPassword
    mutableUsers = false;
    users =
      builtins.mapAttrs
      (
        _: user-attr: {
          inherit (user-attr) isNormalUser description extraGroups initialHashedPassword createHome;
          shell = pkgs.${defaultShell};
        }
      )
      users;
  };
}
