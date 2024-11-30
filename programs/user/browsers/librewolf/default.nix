{ pkgs, lib, config, ... }:
with lib;
let
  inherit (lib) singleton;
  inherit (config.sops) secrets;

  cfg = config.modules.browsers.librewolf;
  settings = (import ./settings.nix { }).settings;
  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    ublock-origin
    privacy-badger
    darkreader
    i-dont-care-about-cookies
    user-agent-string-switcher
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
      # Google.metaData.hidden = true;
      # Bing.metaData.hidden = true;
      # DuckDuckGo.metaData.hidden = true;
      # "Wikipedia (en)".metaData.hidden = true;
    };
  };
in
{
  options.modules.browsers.librewolf = { enable = mkEnableOption "librewolf"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.librewolf-bin
    ];
    programs.librewolf = {
      enable = true;
      # package = pkgs.librewolf-bin;

      profiles = {
        default = {
          id = 0;
          inherit extensions settings search;
        };
        Main = {
          id = 1;
          name = "Main";
          containersForce = true;
          isDefault = true;
          containers = {
            Github = {
              id = 0;
              name = "Github";
              color = "white";
              icon = "fingerprint";
            };

            Mail = {
              id = 1;
              name = "Mail";
              color = "green";
              icon = "tree";
            };

            Google = {
              id = 2;
              name = "Google";
              color = "yellow";
              icon = "chill";
            };

            Microsoft = {
              id = 3;
              name = "Microsoft";
              color = "blue";
              icon = "fingerprint";
            };

            AWS = {
              id = 4;
              name = "AWS";
              color = "yello";
              icon = "fingerprint";
            };

            Forums = {
              id = 5;
              name = "Forums";
              color = "red";
              icon = "food";
            };
          };
          inherit settings search;
        };
        Youtube = {
          id = 2;
          name = "Youtube";
          inherit settings search;
        };
        Linked-In = {
          id = 3;
          name = "Linked-In";
          inherit settings search;
        };
        Work = {
          id = 4;
          name = builtins.readFile secrets.work_name.path;
          inherit settings search;
        };
        Work_Project1 = {
          id = 5;
          name = builtins.readFile secrets.work_project1_name.path;
          inherit settings search;
        };
      };
    };
  };
}
