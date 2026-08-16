{
  pkgs,
  users,
  ...
}: {
  programs.virt-manager.enable = true;
  virtualisation = {
    # NOTE: doesn't work
    waydroid.enable = false;
    spiceUSBRedirection.enable = true;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings = {
        features.cdi = true;
        cdi-spec-dirs = map (username: "/home/${username}/.cdi") (builtins.attrNames users);
      };
    };
    libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = with pkgs; [virtiofsd];
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };
}
# NOTE: Commands
# sudo virsh net-list --all
# sudo virsh net-start default
# sudo virsh net-autostart default

