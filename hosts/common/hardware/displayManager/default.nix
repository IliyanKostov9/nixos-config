_: let
  auto-login-user = "iliyan";
in {
  services = {
    displayManager.autoLogin = {
      enable = true;
      user = auto-login-user;
    };
  };
}
