_: {
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      ovpn_username = {
        mode = "0400";
      };
      ovpn_password = {
        mode = "0400";
      };
    };
  };
}