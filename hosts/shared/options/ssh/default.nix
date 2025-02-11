_: {
  programs.ssh = {
    startAgent = true; # Auto-start ssh-add agent
    knownHostsFiles = [
      ./known_hosts
    ];

  };
}
