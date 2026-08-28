{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.hardware.power-saver;
in {
  options.modules.hardware.power-saver = {enable = mkEnableOption "power-saver ";};

  config = mkIf cfg.enable {
    networking.networkmanager.wifi.powersave = true; # NOTE: Auto turn the bluetooth on or off
    services = {
      fstrim.enable = true;
      power-profiles-daemon.enable = false;
      tlp = {
        enable = true;
        settings = {
          PLATFORM_PROFILE_ON_BAT = "low-power";
          PLATFORM_PROFILE_ON_AC = "balanced";
          CPU_ENERGY_PERF_POLICY_ON_AC = mkForce "performance";
          CPU_MAX_PERF_ON_AC = mkForce 100;
        };
      };
    };
  };
}
