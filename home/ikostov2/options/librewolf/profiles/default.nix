{ pkgs, work_name }:
with pkgs.nur.repos.rycee.firefox-addons;

{
  Main = {
    id = 0;
    name = "Main";
    containersForce = true;
    isDefault = true;
    containers = import ./containers/Main;
    extensions = [
      passbolt
      ublock-origin
      privacy-badger
      darkreader
      i-dont-care-about-cookies
      user-agent-string-switcher
    ];
  };

  Social = {
    id = 1;
    name = "Social";
    containersForce = false;
    isDefault = false;
    extensions = [
      ublock-origin
      privacy-badger
      darkreader
      i-dont-care-about-cookies
      user-agent-string-switcher
    ];
  };
  Youtube = {
    id = 2;
    name = "Youtube";
    containersForce = false;
    isDefault = false;
    containers = import ./containers/Youtube;
    extensions = [
      ublock-origin
      privacy-badger
      darkreader
      i-dont-care-about-cookies
      user-agent-string-switcher
    ];
  };

  Work = {
    id = 3;
    name = work_name;
    containersForce = false;
    isDefault = false;
    extensions = [
      passbolt
      ublock-origin
      privacy-badger
      darkreader
      i-dont-care-about-cookies
      user-agent-string-switcher
    ];
  };

  Test = {
    id = 4;
    name = "Test";
    containersForce = false;
    isDefault = false;
    extensions = [
      ublock-origin
      privacy-badger
      darkreader
    ];
  };
}
