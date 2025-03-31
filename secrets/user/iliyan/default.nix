_: {
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
    defaultSopsFile = builtins.path {
      path = ./env_vars.yaml;
      name = "sops-usr-file-iliyan-env_vars";
    };
    defaultSopsFormat = "yaml";

    secrets = {
      azure_devops_ext_pat = {};
      gh_token = {};
      gitguardian_api_key = {};
      tf_token_app_terraform_io = {};
      tf_org = {};

      work_name = {
        sopsFile = builtins.path {
          path = ./work.yaml;
          name = "sops-usr-secrets-iliyan-work_name";
        };
      };
      work_project1_name = {
        sopsFile = builtins.path {
          path = ./work.yaml;
          name = "sops-usr-secrets-iliyan-work_project1_name";
        };
      };

      work_name_new = {
        sopsFile = builtins.path {
          path = ./work.yaml;
          name = "sops-usr-secrets-iliyan-work_name_new";
        };
      };
    };
  };
}
