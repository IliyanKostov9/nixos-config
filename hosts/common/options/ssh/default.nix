{pkgs, ...}: {
  programs.ssh = {
    startAgent = true; #NOTE: Auto-start ssh-add agent
    enableAskPassword = true;
    askPassword = pkgs.lib.mkForce "${pkgs.seahorse.out}/bin/seahorse";
    knownHostsFiles = [
      ./known_hosts
    ];
    extraConfig = ''

      Host github.com
      IdentityFile ~/.ssh/id_github_personal

      Host ssh.dev.azure.com
      IdentityFile ~/.ssh/id_azure_devops_personal

      Host gitlab.com
      IdentityFile ~/.ssh/id_gitlab_personal

      Host pi
      HostName 192.168.1.99
      User pi
      IdentityFile ~/.ssh/id_pi_rsa
    '';
  };
}
