{pkgs}:
with pkgs.nur.repos.rycee.firefox-addons; {
  Main = {
    id = 0;
    name = "Main";
    containersForce = true;
    isDefault = true;
    containers = import ./containers/Main;
    extensions.packages = [
      passbolt
      ublock-origin
      # privacy-badger
      darkreader
      i-dont-care-about-cookies
      user-agent-string-switcher
    ];
  };
}
