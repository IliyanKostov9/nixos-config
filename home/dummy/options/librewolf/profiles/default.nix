{ pkgs }:
with pkgs.nur.repos.rycee.firefox-addons;
{
  Dummy = {
    id = 0;
    name = "Dummy";
    containersForce = false;
    isDefault = true;
    extensions = [
      ublock-origin
      privacy-badger
      i-dont-care-about-cookies
    ];
  };
  Testarino = {
    id = 1;
    name = "Testarino";
    containersForce = false;
    isDefault = false;
    extensions = [ ];
  };
}
