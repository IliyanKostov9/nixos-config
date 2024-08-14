{ lib, ... }:

{
  user-programs = {
    api = import ./api { inherit lib; };
    browsers = import ./browsers { inherit lib; };
    dbms = import ./dbms { inherit lib; };
    file-compression = import ./file-compression { inherit lib; };
    iot = import ./iot { inherit lib; };
    media = import ./media { inherit lib; };
    password-manager = import ./password-manager { inherit lib; };
    translate = import ./translate { inherit lib; };
    vpn = import ./vpn { inherit lib; };
  };
}
