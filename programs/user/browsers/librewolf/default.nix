{ pkgs, lib, config, ... }:
with lib;
let
  inherit (config.sops) secrets;
  cfg = config.modules.browsers.librewolf;

  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    ublock-origin
    privacy-badger
    darkreader
    i-dont-care-about-cookies
    user-agent-string-switcher
  ];
  extensionsPlusPassbolt = extensions ++ [
    pkgs.nur.repos.rycee.firefox-addons.passbolt
  ];

  settings = import (builtins.toPath ./about-config/settings);
  search = {
    force = true;
    default = "DuckDuckGo";
    privateDefault = "DuckDuckGo";

    engines = {
      DuckDuckGo = {
        urls = lib.singleton {
          template = "https://duckduckgo.com";

          params = lib.singleton {
            name = "q";
            value = "{searchTerms}";
          };
        };
      };
    };
  };
in
{
  options.modules.browsers.librewolf = { enable = mkEnableOption "librewolf"; };
  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;

      profiles = {
        Main = {
          id = 0;
          name = "Main";
          containersForce = true;
          isDefault = true;
          containers = import ./about-config/containers/Main;
          inherit settings search;
          extensions = extensionsPlusPassbolt;
        };
        Youtube = {
          id = 1;
          name = "Youtube";
          inherit settings search extensions;
        };
        Linked-In = {
          id = 2;
          name = "Linked-In";
          inherit settings search extensions;
        };
        Work = {
          id = 3;
          name = builtins.readFile secrets.work_name.path;
          inherit settings search extensions;
        };
        Work_Project1 = {
          id = 4;
          name = builtins.readFile secrets.work_project1_name.path;
          inherit settings search extensions;
        };
      };
    };
  };
}
