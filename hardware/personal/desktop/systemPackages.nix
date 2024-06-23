{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    tree
    patchelf
    unzip
    zlib
    libstdcxx5
    bzip2
    xz
    openssl
    readline
    sqlite
    tcl
    tk
    curl
    libffi
    gnumake
    patch
    libuuid
    vim
    libgccjit
    glibc
    binutils
    gcc
    ncurses
    #pyenv  # broken: unable to install python
    python3
    python311Packages.pip
    python311Packages.pipx
    nodejs_22
    jdk19
    maven
    gradle
    kubectl
    docker
    terraform
    kotlin
    go
    fzf
    dotnetCorePackages.sdk_8_0_1xx
    rustup
    ripgrep
    lua-language-server
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
    # chromium = {
    #   enableWideVine = true;
    # };
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
