{ lib
, ...
}:
{
  gimp = {
    enabled = lib.mkDefault false;
  };

  obs-studio = {
    enabled = lib.mkDefault false;
  };

  vlc = {
    enabled = lib.mkDefault false;
  };
}

