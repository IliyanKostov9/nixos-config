{pkgs, ...}: {
  imports = [
    ./pipewire
    ./pulse-audio
  ];

  environment.systemPackages = with pkgs; [
    vlc
  ];
}
