{ lib, config, pkgs, work_name, work_project1_name }:
let
  plugins = if lib.hasAttr "nur" pkgs then pkgs.nur.repos.rycee.firefox-addons else lib.warn "> Firefox addons are not installed! Please install nur repository to add them!" { };
in
{
  Main = {
    id = 0;
    name = "Main";
    containersForce = true;
    isDefault = true;
    containers = import ./containers/Main;
    extensions = lib.mkIf (lib.hasAttr "firefox-addons" plugins) (with plugins;[
      passbolt
      ublock-origin
      privacy-badger
      darkreader
      i-dont-care-about-cookies
      user-agent-string-switcher
    ]);
  };
  Youtube = {
    id = 1;
    name = "Youtube";
    containersForce = false;
    isDefault = false;
    containers = import ./containers/Youtube;
    extensions = lib.mkIf (lib.hasAttr "firefox-addons" plugins) (with plugins;[
      ublock-origin
      privacy-badger
      darkreader
      i-dont-care-about-cookies
      user-agent-string-switcher
    ]);
  };
  Linked-In = {
    id = 2;
    name = "Linked-In";
    containersForce = false;
    isDefault = false;
    extensions = lib.mkIf (lib.hasAttr "firefox-addons" plugins) (with plugins;[
      ublock-origin
      privacy-badger
      darkreader
      i-dont-care-about-cookies
      user-agent-string-switcher
    ]);
  };

  Work = {
    id = 3;
    name = work_name;
    containersForce = false;
    isDefault = false;
    extensions = lib.mkIf (lib.hasAttr "firefox-addons" plugins) (with plugins;[
      passbolt
      ublock-origin
      privacy-badger
      darkreader
      i-dont-care-about-cookies
      user-agent-string-switcher
    ]);
  };

  Work_Project1 = {
    id = 4;
    name = work_project1_name;
    containersForce = false;
    isDefault = false;
    extensions = lib.mkIf (lib.hasAttr "firefox-addons" plugins) (with plugins;[
      ublock-origin
      privacy-badger
      darkreader
      i-dont-care-about-cookies
      user-agent-string-switcher
    ]);
  };
}
