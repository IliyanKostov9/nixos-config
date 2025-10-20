{pkgs, ...}: {
  programs.virt-manager.enable = true;
  virtualisation = {
    waydroid.enable = false;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = with pkgs; [virtiofsd];
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };
  };
}
# NOTE: Commands
# sudo virsh net-list --all
# sudo virsh net-start default
# sudo virsh net-autostart default

