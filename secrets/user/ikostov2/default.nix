_: {
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
    defaultSopsFile = builtins.path {
      path = ./env_vars.yaml;
      name = "sops-usr-file-ikostov2-env_vars";
    };
    defaultSopsFormat = "yaml";

    secrets = {
      azure_devops_ext_pat = {};

      gh_token = {};
      git_source_owner = {};
      git_source_org = {};
      git_dest_owner = {};
      git_dest_project = {};
      git_dest_ssh_domain = {};
      gitguardian_api_key = {};

      tf_token_app_terraform_io = {};
      tf_org = {};

      work_name = {
        sopsFile = builtins.path {
          path = ./work.yaml;
          name = "sops-usr-secrets-ikostov2-work_name";
        };
      };
      work_project1_name = {
        sopsFile = builtins.path {
          path = ./work.yaml;
          name = "sops-usr-secrets-ikostov2-work_project1_name";
        };
      };
    };
  };
}
