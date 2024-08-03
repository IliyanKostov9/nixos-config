# #########################
# VARIABLES
# ########################

# Default user, change it to your particular username
DEFAULT_USER := ikostov2


##########################
# TARGET
# #######################


.PHONY: help
help:  ## help target to show available commands with information
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: home-update
home-update:  ## Build home configuration for default user
	home-manager switch --flake .#${DEFAULT_USER} --show-trace --option eval-cache false
	
.PHONY: sys-update-pd
sys-update-pd: ## Build system configuration for host: personal desktop
	sudo nixos-rebuild switch --flake .#hosts-personal-desktop --show-trace
		
.PHONY: sys-update-wl
sys-update-wl: ## Build system configuration for host: work laptop 
	sudo nixos-rebuild switch --flake .#hosts-work-laptop --show-trace --option eval-cache false --impure
	
.PHONY: flake-check
flake-check: ## Evaluate flake and build its checks
	nix flake check
	
.PHONY: flake-upgrade
flake-upgrade:  ## Upgrade flake related dependencies
	nix flake update

.PHONY: clean
clean: ## Remove old user generations
	nix-collect-garbage -d

.PHONY: clean-su
clean-su: ## Remove old system generations
	sudo nix-collect-garbage -d

.PHONY: show-gen
show-gen: ## Show NixOS generations
	nix-env --list-generations

.PHONY: deduplicate
deduplicate: ## Optimize nix store by making each package unique. Warning: The operation is resource intensive
	nix store optimise
