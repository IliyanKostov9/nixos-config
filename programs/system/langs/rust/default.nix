{ pkgs
, config
, ...
}:

{
  # Needed for Neovim rnix-lsp and rnix-fmt
  environment.systemPackages = with pkgs; [ rustup ];
} 
