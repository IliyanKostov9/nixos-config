_: {
  security.rtkit.enable = true;
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
}
