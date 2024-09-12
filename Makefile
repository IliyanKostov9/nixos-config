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

.PHONY: setup
setup: ## Setup your nixos system
	echo "Labeling mount points with NIXOS prefix..."
	sudo e2label $(shell findmnt -n -o SOURCE /) NIXOS_SD
	sudo fatlabel $(shell findmnt -n -o SOURCE /boot) NIXOS_BOOT
	echo "Labeling done! Mountpoints:"
	lsblk -o FSTYPE,LABEL,MOUNTPOINT

.PHONY: home-update
home-update:  ## Build home configuration for default user
	home-manager switch --flake .#${DEFAULT_USER} --show-trace --impure --option eval-cache false |& nom
	
.PHONY: sys-update-pd
sys-update-pd: ## Build system configuration for host: personal desktop
	sudo -v && sudo nixos-rebuild switch --flake .#hosts-personal-desktop --show-trace |& nom
		
.PHONY: sys-update-wl
sys-update-wl: ## Build system configuration for host: work laptop 
	sudo -v && sudo nixos-rebuild switch --flake .#hosts-work-laptop --show-trace --impure --option eval-cache false |& nom

.PHONY: flake-check
flake-check: ## Evaluate flake and build its checks
	nix flake check --all-systems |& nom
	
.PHONY: flake-upgrade
flake-upgrade:  ## Upgrade flake related dependencies
	nix flake update |& nom

.PHONY: flake-meta
flake-meta: ## Check flake deps
	nix flake metadata |& nom

.PHONY: clean
clean: ## Remove old user generations
	nix-collect-garbage -d |& nom

.PHONY: clean-su
clean-su: ## Remove old system generations
	sudo -v && sudo nix-collect-garbage -d |& nom

.PHONY: show-gen
show-gen: ## Show NixOS generations
	nix-env --list-generations |& nom

.PHONY: unique
unique: ## Optimize nix store by making each package unique. Warning: The operation is resource intensive
	nix store optimise |& nom

