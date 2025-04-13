_: {
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
    defaultSopsFile = builtins.path {
      path = ./secrets.yaml;
      name = "sops-system-file-secrets";
    };
    defaultSopsFormat = "yaml";

    secrets = {
      ovpn_username = {
        mode = "0640";
        restartUnits = ["openvpn-personalVPN.service"];
      };
      ovpn_password = {
        mode = "0640";
        restartUnits = ["openvpn-personalVPN.service"];
      };
    };
  };
}
