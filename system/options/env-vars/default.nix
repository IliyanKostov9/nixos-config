{ config, lib, pkgs, ... }:
{
  # Env vars
  environment.variables = {
    EDITOR = "nvim";
    JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
    PATH = "${pkgs.jdk}/bin:" + builtins.getEnv "PATH";
  };
}
