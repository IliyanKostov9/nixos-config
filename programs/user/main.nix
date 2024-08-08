{ lib, ... }:

{
  user-programs = {
    api = import ./api { inherit lib; };
  };
}
