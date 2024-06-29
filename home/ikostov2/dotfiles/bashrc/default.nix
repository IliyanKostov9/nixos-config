{ pkgs
, config
, ...
}:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
  home = {
    shellAliases = {
      nvim-su = "sudo -E nvim .";
      clip = "xclip -selection clipboard";
      timmy = "tmux new-session '~/.local/bin/tmux-ls-sessionizer'";
      buzz = "cd $(find . -type d | fzf)";
      git-all = "git add . && git commit && ( git push || git push --set-upstream origin master )";
      py-setup-venv = "~/.local/bin/python/python-venv-setup";
      mvn-spring = "mvn spring-boot:run";
      mvn-deps = "mvn dependency:resolve";
    };
    sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      GH_TOKEN = "cat ~/.config/secrets/GH_TOKEN";
      # GTK_THEME = "whitesur-gtk-theme";
    };
  };
}
