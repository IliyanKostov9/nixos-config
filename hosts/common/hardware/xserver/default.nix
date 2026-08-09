_: {
  services.xserver = {
    enable = true;
    # Disable screen turning off after 10 mins
    deviceSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
      Option "DPMS" "false"
    '';
  };
}
