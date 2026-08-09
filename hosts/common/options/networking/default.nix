{
  host_attr,
  config,
  lib,
  ...
}:
with lib; let
  host-name = host_attr.host-name or "baks";
  cfg = config.modules.options.networking;
in {
  options.modules.options.networking = {
    nameservers = mkOption {
      type = types.listOf types.str;
      default = [];
      description = mkDoc ''
        Nameservers for the device to send DNS traffic
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.nameservers == [] || builtins.all (ip: builtins.match "((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" ip != null) cfg.nameservers;
        message = ''
          Name server is incorrect: ${lib.concatStringsSep '', '' cfg.nameservers}!
        '';
      }
    ];

    networking = {
      hostName = host-name;
      inherit (cfg) nameservers;
      networkmanager.enable = true;
      useDHCP = lib.mkDefault true;
      firewall = {
        enable = true;
        allowedTCPPorts = [3003];
        allowedUDPPortRanges = [
          {
            from = 3000;
            to = 4000;
          }
        ];
      };
    };
  };
}
