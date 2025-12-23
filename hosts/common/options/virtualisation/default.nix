{pkgs, ...}: {
  programs.virt-manager.enable = true;
  virtualisation = {
    # NOTE: doesn't work
    waydroid.enable = false;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings = {
        features.cdi = true;
        # TODO: Do not hardcode this
        cdi-spec-dirs = ["/home/iliyan/.cdi"];
      };
    };
    spiceUSBRedirection.enable = true;
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

