{ pkgs, ... }:

let

  shell_path = "/etc/nixos/programs/user/dev/shell/bin";
in
{
  shellAliases = {

    # Git
    git-all = "${shell_path}/bash/git/git-all.sh";
    git-root = "cd $( git rev-parse --show-toplevel )";
    git-prt = "gh pr create --body '$(cat .github/PULL_REQUEST_TEMPLATE.md)'";
    git-rob = "${shell_path}/bash/git/git-rob.sh";
    git-cache = "git rm -r --cached";
    git-rm-local-brv = "git fetch -p && for branch in `LC_ALL=C git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D $branch; done";

    # Other
    viber = "nix-shell '${shell_path}/nix/viber/shell.nix'";

    # Python
    py = "python3";
    py-setup-venv = "${shell_path}/bash/python/python-venv-setup.sh";
    venv = "eval $(pdm venv activate)";
    pdm-sync = "pdm install && pdm sync --clean";
    pdm-export = "pdm export -o requirements.txt";
    py-nix-sh = "nix-shell '${shell_path}/nix/python/shell.nix'";

    # Maven
    mvn-jar = "mvn -f pom.xml clean package";
    mvn-spring = "mvn spring-boot:run";
    mvn-deps = "mvn dependency:resolve";

    # Infra
    tf = "terraform";
    dc = "docker";
    ku = "kubectl";

    # Utils
    clip = "xclip -selection clipboard";
    bz = "cd $(find . -type d | fzf)";
    ls = "eza";
    ls-tr = "${shell_path}/bash/eza/tree-icons.sh";
  };

  sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    GTK_THEME = "Adwaita:dark";
    MANPAGER = "nvim +Man!";
    GOROOT = "${pkgs.go}";
    GOPATH = "$HOME/go";
    GOPROXY = "https://proxy.golang.org,direct";
    GOSUMDB = "sum.golang.org";
    # KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };
}
