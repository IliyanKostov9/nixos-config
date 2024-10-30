{ config, pkgs }:

let
  secrets = config.sops.secrets;
in
{
  shellAliases = {
    # Python
    py = "python3";
    pip = "uv pip";
    venv = "source .venv/bin/activate";

    pip-lock = "uv pip compile pyproject.toml -o requirements.txt";
    pip-sync = "uv pip sync requirements.txt";
    pip-sync-toml = "uv pip sync pyproject.toml";

    # venv = "eval $(pdm venv activate)";
    pdm-sync = "pdm install && pdm sync --clean";
    pdm-export = "pdm export -o requirements.txt";

    # Maven
    mvn-jar = "mvn -f pom.xml clean package";
    mvn-spring = "mvn spring-boot:run";
    mvn-deps = "mvn dependency:resolve";
    mvn-deps-tree = "mvn dependency:tree";

    # Infra
    tf = "terraform";
    dc = "docker";
    dcc = "docker compose";
    ku = "kubectl";

    # Utils
    gitroot = "cd $(git root)";
    clip = "xclip -selection clipboard";
    bz = "cd $(fzf-search)";
    ls = "eza";
    cat = "bat --theme='base16-256'";
    base = "basename $(pwd)";
  };

  sessionVariables = {
    NIX_LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    MANPAGER = "nvim +Man!";
    GTK_THEME = "Adwaita:dark";
  } // (if builtins.pathExists "${builtins.getEnv "HOME"}/.config/sops-nix" then {
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

    GITGUARDIAN_API_KEY = "$(command cat ${secrets.gitguardian_api_key.path})";

    TF_TOKEN_app_terraform_io = "$(command cat ${secrets.tf_token_app_terraform_io.path})";
    TF_ORG = "$(command cat ${secrets.tf_org.path})";

  } else { });
}

