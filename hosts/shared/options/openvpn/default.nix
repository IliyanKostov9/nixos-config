{ host_attr, ... }:
{
  services.openvpn.servers = {
    personalVPN = {
      # TODO: Fix the dependency issue, where we assume the auto login user has ovpn file located at that path 
      config = "config /home/${host_attr.auto-login-user}/.config/openvpn/personalVPN.ovpn";
      updateResolvConf = true;
      autoStart = true;
    };
  };
}
