{ pkgs
, config
, ...
}:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
  home.shellAliases = {
    vpn-stop = "systemctl stop openvpn-personalVPN.service";
    vpn-start = "systemctl start openvpn-personalVPN.service";
    clip = "xclip -selection clipboard";
    timmy = "tmux new-session '~/.local/bin/tmux-ls-sessionizer'";
    buzz = "cd $(find . -type d | fzf)";
    git-all = "git add . && git commit && ( git push || git push --set-upstream origin master )";
    py-setup-venv = "~/.local/bin/python/python-venv-setup";
    mvn-spring = "mvn spring-boot:run";
    mvn-deps = "mvn dependency:resolve";
  };
}
