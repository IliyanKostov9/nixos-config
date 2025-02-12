{ pkgs, ... }:
{
  programs.ssh = {
    startAgent = true; #NOTE: Auto-start ssh-add agent
    enableAskPassword = true;
    askPassword = pkgs.lib.mkForce "${pkgs.seahorse.out}/bin/seahorse";
    knownHostsFiles = [
      ./known_hosts
    ];
  };
}
