{ config, ... }:
{
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
    defaultSopsFile = ./env_vars.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      azure_devops_ext_pat = { };

      gh_token = { };
      git_source_owner = { };
      git_source_org = { };
      git_dest_owner = { };
      git_dest_project = { };
      git_dest_ssh_domain = { };
      gitguardian_api_key = { };

      tf_token_app_terraform_io = { };
      tf_org = { };

      work_name = { };
      work_project1_name = { };
      ovpn_username = {
        mode = "0400";
        sopsFile = ./system.yaml;
      };
      ovpn_password = {
        mode = "0400";
        sopsFile = ./system.yaml;
      };
    };
  };
}
