{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ virt-manager ];
  # virtualisation = {
  #   libvirtd.enable = true;
  #   spiceUSBRedirection.enable = true;
  # };
}
