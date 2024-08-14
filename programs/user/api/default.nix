{ lib
, ...
}:
{
  postman = {
    enabled = lib.mkDefault false;
  };
}
