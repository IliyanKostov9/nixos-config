{ pkgs, lib, config, ... }:
with lib;
let
  inherit (lib) singleton;
  inherit (config.sops) secrets;

  cfg = config.modules.browsers.librewolf;
  settings = {
    # Enable vertical tabs
    "sidebar.verticalTabs" = true;
    "sidebar.revamp" = true;
    "sidebar.visibility" = "always-show";
    "sidebar.main.tools" = "aichat,history";
    "sidebar.position_start" = true;

    "identity.fxaccounts.enabled " = true;
    "browser.tabs.hoverPreview.showThumbnails " = false;
    "browser.contentblocking.category" = "strict";
    "browser.download.panel.shown" = true;
    "middlemouse.paste" = false;
    "general.autoScroll" = true;
    "browser.tabs.warnOnClose" = true;
    "browser.toolbars.bookmarks.visibility" = "newtab";
    "browser.sessionstore.restore_pinned_tabs_on_demand" = true;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

    "browser.urlbar.suggest.bookmark" = true;
    "browser.urlbar.suggest.engines" = true;
    "browser.urlbar.suggest.history" = true;
    "browser.urlbar.suggest.openpage" = true;
    "browser.urlbar.suggest.topsites" = true;

    # Disable annoying firefox builtin plugins
    "extensions.pocket.enabled" = false;
    "browser.tabs.tabmanager.enabled" = false;
    "browser.firefox-view.virtual-list.enabled" = false;
    "browser.urlbar.suggest.pocket" = false;

    "extensions.pocket.showHome" = true;
    "extensions.autoDisableScopes" = 0;
    # Privacy settings
    "webgl.disabled" = false;
    "privacy.resistRingerprinting" = false;
    "privacy.clearOnShutdown.history" = false;
    "privacy.clearOnShutdown.downloads" = false;
    "privacy.clearOnShutdown.cookies" = false;
    "network.cookie.lifetimePolicy" = 0;
    "geo.enabled" = false;
  };
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
        Main = {
          id = 0;
          name = "Main";
          containersForce = true;
          isDefault = true;
          containers = {
            Github = {
              id = 0;
              name = "Github";
              color = "toolbar";
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
              color = "turquoise";
              icon = "fingerprint";
            };

            AWS = {
              id = 4;
              name = "AWS";
              color = "yellow";
              icon = "fingerprint";
            };

            Forums = {
              id = 5;
              name = "Forums";
              color = "red";
              icon = "food";
            };
          };
          inherit settings search extensions;
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
