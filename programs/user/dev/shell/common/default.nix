{
  env-vars,
  pkgs,
}: let
  clip =
    if builtins.getEnv "XDG_SESSION_TYPE" == "wayland"
    then "wl-copy"
    else "xclip -selection clipboard";
in {
  shellAliases = {
    # Python
    py = "python3";
    uy = "uv run";
    pip = "uv pip";
    venv = "source .venv/bin/activate";

    pip-lock = "uv pip compile pyproject.toml -o requirements.txt";
    pip-sync = "uv pip sync requirements.txt";
    pip-sync-toml = "uv pip sync pyproject.toml";

    # venv = "eval $(pdm venv activate)";
    pdm-sync = "pdm install && pdm sync --clean";
    pdm-export = "pdm export -o requirements.txt";
    uv-export = "uv pip compile pyproject.toml -o requirements.txt";

    # Maven
    mvn-jar = "mvn -f pom.xml clean package";
    mvn-cc-jar = "mvn -s ~/.m2/cc-settings.xml -f pom.xml clean package";
    mvn-spring = "mvn spring-boot:run";
    mvn-deps = "mvn dependency:resolve";
    mvn-deps-tree = "mvn dependency:tree";
    mvn-run = "mvn compile exec:java";

    # Infra
    tf = "terraform";
    dc = "docker";
    dcc = "docker compose";
    kc = "kubectl";

    # Utils
    gitroot = "cd $(git root)";
    gitunstage = "git restore --staged";
    gitig = "git-ignore";
    inherit clip;
    lo = "libreoffice";
    ls = "eza";
    cat = "bat";
    base = "basename $(pwd)";
  };

  sessionVariables =
    pkgs.lib.recursiveUpdate
    {
      NIX_LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib:${pkgs.libapparmor}/lib";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      MANPAGER = "nvim +Man!";
      GTK_THEME = "Adwaita:dark";
    }
    env-vars;
}
