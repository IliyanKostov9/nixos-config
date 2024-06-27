{ config, lib, pkgs, ... }:
{
  services.openvpn.servers = {
    personalVPN = {
      config = "config /home/ikostov2/.config/openvpn/personalVPN.ovpn";
      updateResolvConf = true;
      autoStart = true;
    };
  };
}
