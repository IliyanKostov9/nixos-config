_: {
  security.rtkit.enable = true;
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
}
