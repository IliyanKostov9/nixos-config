{ pkgs, ... }:

let
  shell_path = "/etc/nixos/home/ikostov2/shell";
in
{
  shellAliases = {
    nvim-su = "sudo -E nvim .";
    clip = "xclip -selection clipboard";
    buzz = "cd $(find . -type d | fzf)";
    git-all = "git add . && git commit && ( git push || git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD) )";
    git-root = "cd $( git rev-parse --show-toplevel )";
    git-rob = "${shell_path}/bash/git/git-rob.sh";
    git-prt = "gh pr create --body '$(cat .github/PULL_REQUEST_TEMPLATE.md)'";
    py-setup-venv = "${shell_path}/bash/python/python-venv-setup.sh";
    venv = "eval $(pdm venv activate)";
    pdmm = "pdm install && pdm sync --clean";
    pdm-export = "pdm export -o requirements.txt";
    py-nix-sh = "nix-shell '${shell_path}/nix/python/shell.nix'";
    mvn-jar = "mvn -f pom.xml clean package";
    mvn-spring = "mvn spring-boot:run";
    mvn-deps = "mvn dependency:resolve";
    tf = "terraform";
    dc = "docker";
    ku = "kubectl";
  };
  sessionVariables = {
    XDG_BIN_HOME = "$HOME/.local/bin";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    GTK_THEME = "Adwaita:dark";
    # KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };
}
