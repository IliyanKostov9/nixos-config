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

      Host pi
      HostName 192.168.1.99
      User pi
      IdentityFile ~/.ssh/id_pi_rsa
    '';
  };
}
