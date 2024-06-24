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

.PHONY: show-gens
show-gen:
	nix-env --list-generations

.PHONY: deduplicate
deduplicate: ## Optimize nix store by making each package unique. Warning: The operation is resource intensive
	nix store optimise
