{ pkgs, lib, config, ... }:
with lib;
let
  inherit (lib) singleton;
  inherit (config.sops) secrets;

  cfg = config.modules.browsers.librewolf;

  settings = import (builtins.toPath ./settings.nix);
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
  search = {
    force = true;
    default = "DuckDuckGo";
    privateDefault = "DuckDuckGo";

    engines = {
      DuckDuckGo = {
        urls = singleton {
          template = "https://duckduckgo.com";

          params = singleton {
            name = "q";
            value = "{searchTerms}";
          };
        };
      };
      Google.metaData.hidden = true;
      Bing.metaData.hidden = true;
      DuckDuckGo.metaData.hidden = true;
      "Wikipedia (en)".metaData.hidden = true;
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
          containers = {
            None = {
              id = 0;
              name = "None";
              color = "orange";
              icon = "circle";
            };

            Github = {
              id = 1;
              name = "Github";
              color = "blue";
              icon = "fingerprint";
            };

            Mail = {
              id = 2;
              name = "Mail";
              color = "green";
              icon = "tree";
            };

            Google = {
              id = 3;
              name = "Google";
              color = "yellow";
              icon = "chill";
            };

            Microsoft = {
              id = 4;
              name = "Microsoft";
              color = "turquoise";
              icon = "fingerprint";
            };

            AWS = {
              id = 5;
              name = "AWS";
              color = "yellow";
              icon = "fingerprint";
            };

            Forums = {
              id = 6;
              name = "Forums";
              color = "red";
              icon = "food";
            };
          };

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
