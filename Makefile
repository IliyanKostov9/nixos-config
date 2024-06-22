.PHONY: home-update
home-update:
	home-manager switch --flake .#ikostov2 --show-trace
	
.PHONY: sys-update
sys-update:
	sudo nixos-rebuild switch --flake .#ikostov2 --show-trace
	
.PHONY: flake-check
flake-check:
	nix flake check

.PHONY: clean
clean:
	nix-collect-garbage -d
