{ lib, config, pkgs }:
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
  Youtube = {
    id = 1;
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
  Linked-In = {
    id = 2;
    name = "Linked-In";
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

  Work = {
    id = 3;
    name = config.globals.work_name;
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

  Work_Project1 = {
    id = 4;
    name = config.globals.work_project1_name;
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
}
