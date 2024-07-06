{ pkgs
, config
, lib
, ...
}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
   autocd= true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "gradle"
        "maven"
        #"fzf"
        #"ansible"
        "npm"
        "python"
        "pip"
        "nvim"
        "history"
        "node"
        "rust"
        "aws"
        "azure"
        "docker"
        "kubectl"
        "tmux"
        "terraform"
      ];
    };
    shellAliases = {
      nvim-su = "sudo -E nvim .";
      clip = "xclip -selection clipboard";
      buzz = "cd $(find . -type d | fzf)";
      git-all = "git add . && git commit && ( git push || git push --set-upstream origin master )";
      git-root = "cd $( git rev-parse --show-toplevel )";
      py-setup-venv = "~/.local/bin/python/python-venv-setup";
      mvn-spring = "mvn spring-boot:run";
      mvn-deps = "mvn dependency:resolve";
    };
    sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      GH_TOKEN = "cat ~/.config/secrets/GH_TOKEN";
      GTK_THEME = "Adwaita:dark";
    };
    interactiveShellInit = ''
      export KEYTIMEOUT=1
      ${plugins}
      bindkey -v
      '';
  };
}
