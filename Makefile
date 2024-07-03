.PHONY: home-update
home-update:
	home-manager switch --flake .#ikostov2 --show-trace
	
.PHONY: sys-update-pd
sys-update-pd:
	sudo nixos-rebuild switch --flake .#ikostov2-personal-desktop --show-trace
		
.PHONY: sys-update-wl
sys-update-wl:
	sudo nixos-rebuild switch --flake .#ikostov2-work-laptop --show-trace
	
.PHONY: flake-check
flake-check:
	nix flake check
	
.PHONY: flake-upgrade
flake-upgrade:
	nix flake update

.PHONY: clean
clean:
	nix-collect-garbage -d

.PHONY: show-gen
show-gen:
	nix-env --list-generations

.PHONY: deduplicate
deduplicate: ## Optimize nix store by making each package unique. Warning: The operation is resource intensive
	nix store optimise
