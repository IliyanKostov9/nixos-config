{ config, pkgs }:

let
  secrets = config.sops.secrets;
in
{
  shellAliases = {

    # Git
    git-root = "cd $( git rev-parse --show-toplevel )";
    git-prt = "gh pr create --body '$(cat .github/PULL_REQUEST_TEMPLATE.md)'";
    git-rm-local-brv = "git fetch -p && for branch in `LC_ALL=C git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D $branch; done";

    # Python
    py = "python3";
    venv = "eval $(pdm venv activate)";
    pdm-sync = "pdm install && pdm sync --clean";
    pdm-export = "pdm export -o requirements.txt";

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
    bz = "cd $(fzf-file-search)";
    ls = "eza";
    cat = "bat --theme='base16-256'";
  };

  sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    MANPAGER = "nvim +Man!";
    GTK_THEME = "Adwaita:dark";
    # Secrets

    AWS_ACCESS_KEY_ID = "$(command cat ${secrets.aws_access_key.path})";
    AWS_SECRET_ACCESS_KEY = "$(command cat ${secrets.aws_secret_access_key.path})";
    AWS_REGION = "$(command cat ${secrets.aws_region.path})";

    AZURE_DEVOPS_EXT_PAT = "$(command cat ${secrets.azure_devops_ext_pat.path})";

    GH_TOKEN = "$(command cat ${secrets.gh_token.path})";
    GIT_SOURCE_OWNER = "$(command cat ${secrets.git_source_owner.path})";
    GIT_SOURCE_ORG = "$(command cat ${secrets.git_source_org.path})";
    GIT_DEST_OWNER = "$(command cat ${secrets.git_dest_owner.path})";
    GIT_DEST_PROJECT = "$(command cat ${secrets.git_dest_project.path})";
    GIT_DEST_SSH_DOMAIN = "$(command cat ${secrets.git_dest_ssh_domain.path})";

    TF_TOKEN_app_terraform_io = "$(command cat ${secrets.tf_token_app_terraform_io.path})";
    TF_ORG = "$(command cat ${secrets.tf_org.path})";
  };
}

