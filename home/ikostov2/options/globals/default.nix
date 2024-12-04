{ config, ... }:
let
  inherit (config.sops) secrets;
in
{
  config.globals = {
    work_project1_name = if (!lib.trivial.inPureEvalMode) then builtins.readFile secrets.work_project1_name.path else "Work_Project1";
    work_name = if (!lib.trivial.inPureEvalMode) then builtins.readFile secrets.work_name.path else "Work";
  };
}
