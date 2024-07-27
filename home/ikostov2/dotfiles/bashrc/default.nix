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
      buzz = "cd $(find . -type d | fzf)";
      git-all = "git add . && git commit && ( git push || git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD) )";
      git-root = "cd $( git rev-parse --show-toplevel )";
      # py-setup-venv = "~/.local/bin/python/python-venv-setup";
      mvn-spring = "mvn spring-boot:run";
      mvn-deps = "mvn dependency:resolve";
    };
    sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };
  };
}
