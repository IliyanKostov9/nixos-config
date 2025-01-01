{ lib, config, pkgs, work_name, work_project1_name }:
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

  Work = {
    id = 2;
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

  Work_Project1 = {
    id = 3;
    name = work_project1_name;
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
