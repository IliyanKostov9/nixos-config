{pkgs, ...}: {
  systemd = {
    user.services.mpris-proxy = {
      description = "Mpris proxy";
      after = ["network.target" "sound.target"];
      wantedBy = ["default.target"];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
    services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };
  };
}
