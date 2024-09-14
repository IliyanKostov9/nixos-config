{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.librewolf;
in
{
  options.modules.librewolf = { enable = mkEnableOption "librewolf"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.librewolf
    ];

    programs.librewolf = {
      enable = true;
      settings =
        {
          # about:config
          "identity.fxaccounts.enabled " = true;

          "browser.contentblocking.category" = "strict";
          "browser.download.panel.shown" = true;
          "middlemouse.paste" = false;
          "general.autoScroll" = true;
          # "gnomeTheme.hideSingleTab" = true;
          "browser.tabs.warnOnClose" = true;
          # "browser.toolbars.bookmarks.visibility" = "never";
          "browser.sessionstore.restore_pinned_tabs_on_demand" = true;

          "browser.urlbar.suggest.bookmark" = true;
          "browser.urlbar.suggest.engines" = true;
          "browser.urlbar.suggest.history" = true;
          "browser.urlbar.suggest.openpage" = true;
          "browser.urlbar.suggest.topsites" = true;

          "webgl.disabled" = false;
          "privacy.resistRingerprinting" = false;
          # Box browser window
          "privacy.resistFingerprinting.letterboxing" = false;

          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.downloads" = false;
          "privacy.clearOnShutdown.cookies" = false;
          "network.cookie.lifetimePolicy" = 0;

          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "geo.enabled" = false;

          # "browser.policies.runOncePerModification.extensionsInstall" 
        };
    };

  };

}
