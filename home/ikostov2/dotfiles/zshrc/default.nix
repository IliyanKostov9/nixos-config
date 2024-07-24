{ pkgs
, config
, lib
, ...
}:

let
  shell_path = "/etc/nixos/home/ikostov2/shell";
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = false;
    autocd = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      theme = "kardan"; # simple
      plugins = [
        "git"
        #"gradle"
        #"fzf"
        "ansible"
        "npm"
        "python"
        "pip"
        #"mvn"
        "history"
        "node"
        # "rust"
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
      git-all = "git add . && git commit && ( git push || git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD) )";
      git-root = "cd $( git rev-parse --show-toplevel )";
      py-setup-venv = "${shell_path}/bash/python/python-venv-setup.sh";
      py-nix-sh = "nix-shell '${shell_path}/nix/python/shell.nix'";
      mvn-jar = "mvn -f pom.xml clean package";
      mvn-spring = "mvn spring-boot:run";
      mvn-deps = "mvn dependency:resolve";
    };
    sessionVariables = {
      XDG_BIN_HOME = "$HOME/.local/bin";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      # GH_TOKEN = "cat ~/.config/secrets/GH_TOKEN";
      KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
    };
    initExtra = ''
      bindkey "''${key[Up]}" up-line-or-search
      bindkey -v
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey "^A" vi-beginning-of-line
      bindkey "^E" vi-end-of-line
    '';
  };
}

