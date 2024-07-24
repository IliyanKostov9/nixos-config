{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
    #pyenv  # broken: unable to install python
    python3
    python311Packages.pip
    python311Packages.pipx
  ];
} 
