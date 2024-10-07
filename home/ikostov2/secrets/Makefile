SECRET_FILE ?= zshrc

.PHONY: unlock
unlock:
	nix-shell -p sops --run "sops ${SECRET_FILE}.yaml"
