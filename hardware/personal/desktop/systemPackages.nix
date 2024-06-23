{ config, lib, pkgs, ... }:

{
  imports = [
    ../../../programs/system
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services = {
    openssh.enable = true;
    libinput.enable = true;
    openvpn.servers = {
      personalVPN = {
        config = "config /home/ikostov2/.config/openvpn/personalVPN.ovpn";
        updateResolvConf = true;
        autoStart = true;
      };
    };
  };
  # Enable nerd fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "0xProto" ]; })
  ];

  # Env vars
  environment.variables = {
    EDITOR = "nvim";
    JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
    PATH = "${pkgs.jdk}/bin:" + builtins.getEnv "PATH";
  };

  # Enable programs
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };
  # For Android
  programs.adb.enable = true;
  programs.gpaste.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Quemu
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  # Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
