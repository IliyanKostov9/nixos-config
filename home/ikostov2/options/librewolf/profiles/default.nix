{ lib, config }:
let
  inherit (config.sops) secrets;
in
{
  Main = {
    id = 0;
    name = "Main";
    containersForce = true;
    isDefault = true;
    containers = import ../containers;
  };
  Youtube = {
    id = 1;
    name = "Youtube";
    containersForce = false;
    isDefault = false;
  };
  Linked-In = {
    id = 2;
    name = "Linked-In";
    containersForce = false;
    isDefault = false;
  };
  Work_Project1 = {
    id = 3;
    name =
      if (!lib.trivial.inPureEvalMode) then builtins.readFile secrets.work_project1_name.path else "Work_Project1";
    containersForce = false;
    isDefault = false;
  };
}
