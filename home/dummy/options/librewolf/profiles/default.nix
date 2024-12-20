{ lib, config, pkgs }:
let
  plugins = if lib.hasAttr "nur" pkgs then pkgs.nur.repos.rycee.firefox-addons else lib.warn "> Firefox addons are not installed! Please install nur repository to add them!" { };
in
{
  Dummy = {
    id = 0;
    name = "Dummy";
    containersForce = false;
    isDefault = true;
    extensions = lib.mkIf (lib.hasAttr "firefox-addons" plugins) (with plugins;[
      ublock-origin
      privacy-badger
      i-dont-care-about-cookies
    ]);
  };
  Testarino = {
    id = 1;
    name = "Testarino";
    containersForce = false;
    isDefault = false;
    extensions = [ ];
  };
}
