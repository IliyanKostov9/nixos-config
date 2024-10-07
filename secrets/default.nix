{ config, ... }:
{
  sops = {
    gnupg.home = "/var/lib/sops";
    gnupg.sshKeyPaths = [ ];
    # sops.defaultSopsFile = ./zshrc.yaml;
    defaultSopsFormat = "yaml";
    secrets.hello = {
      sopsFile = ./zshrc.yaml;
      key = "hello";
      path = "%r/hello.txt";
    };
  };

}
