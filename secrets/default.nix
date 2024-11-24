{ config, ... }:
{
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
    defaultSopsFile = ./env_vars.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      aws_access_key = { };
      aws_secret_access_key = { };
      aws_region = { };

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

      ovpn_username = {
        mode = "0400";
      };
      ovpn_password = {
        mode = "0400";
      };
    };
  };
}
