{config, ...}: {
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
    defaultSopsFile = builtins.path {
      path = ./secrets.yaml;
      name = "sops-system-file-secrets";
    };
    defaultSopsFormat = "yaml";

    secrets = {
      networking_search = {};
      ovpn_username = {};
      ovpn_password = {};
    };
    templates."ovpn-auth" = {
      content = ''
        ${config.sops.placeholder.ovpn_username}
        ${config.sops.placeholder.ovpn_password}
      '';
      restartUnits = ["openvpn-personalVPN.service"];
    };
  };
}
