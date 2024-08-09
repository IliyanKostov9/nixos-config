{ lib
, ...
}:
{

  librewolf = {
    enabled = lib.mkDefault false;
  };

  chromium = {
    enabled = lib.mkDefault false;
    options = {
      programs.chromium.enable = false;
      nixpkgs.config.chromium = {
        enableWideVine = true;
      };
    };
  };

  microsoft-edge = {
    enabled = lib.mkDefault false;
  };

}
