HDD_PART := /dev/sdb1

##########################
# TARGET
# #######################

.PHONY: help
help:  ## help target to show available commands with information
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup label secure-boot secure-boot-sign
setup: label secure-boot secure-boot-sign

label: ## Setup your nixos system
	echo "Labeling mount points with NIXOS prefix..."
	sudo e2label $(shell findmnt -n -o SOURCE /) NIXOS_SD
	sudo ntfslabel $(HDD_PART) NIXOS_HDD
	sudo fatlabel $(shell findmnt -n -o SOURCE /boot) NIXOS_BOOT
	echo "Labeling done! Mountpoints:"
	lsblk -o FSTYPE,LABEL,MOUNTPOINT
	sudo blkid

secure-boot: ## Enable secure boot
	echo "Currently secure boot is not enabled"
	bootctl status
	echo -e "Now the process of secure boot will start.\n Press ENTER to continue"
	read
	echo "Creating keys..."
	sudo sbctl create-keys
	printf "Keys created! \n\
		Now you have to manually enable secure mode in your PC by following the instructions:\n\n\
		1. Go to Security > Secure boot\n\
		2. Click (Secure Boot) to enabled\n\
		3. Click (Reset to Setup Mode)\n\n\
		After you enable secure boot and get logged back in your machine, run 'make secure-boot-sign'\n
	"
	echo "Press ENTER to continue"
	read
	sudo reboot

secure-boot-sign:
	echo "Enrolling keys..."
	sudo sbctl enroll-keys --microsoft
	echo -e "Now you'll be rebooted again.\n\Finally after reboot type `bootctl status` to check if secure boot is signed\n\nPress ENTER to continue"
	read
	sudo reboot


.PHONY: build sys-update home-update 
build: sys-update home-update 

home-update:  ## Build home configuration for default user
	home-manager switch --flake .#$(shell whoami) --show-trace --impure |& nom
#	tmux source-file ~/.config/tmux/tmux.conf 
	
.PHONY: sys-update
sys-update: ## Build system configuration for all hosts
	@./scripts/sys-update.sh


.PHONY: clean clean-sys clean-usr optimise
clean: clean-sys clean-usr optimise

clean-usr : ## Remove old user generations
	nix-collect-garbage -d |& nom

clean-sys: ## Remove old system generations
	sudo -v && sudo nix-collect-garbage -d |& nom

optimise: ## Optimize nix store by making each package unique. Warning: The operation is resource intensive
	nix store optimise

################### UTILS ########################

.PHONY: flake flake-check flake-upgrade flake-meta
flake: 
	$(MAKE) --no-print-directory help

flake-check: ## Evaluate flake and build its checks
	nix flake check -L |& nom

flake-upgrade:  ## Upgrade flake related dependencies
	nix flake update |& nom

flake-meta: ## Check flake deps
	nix flake metadata |& nom

.PHONY: gen
gen: ## Show NixOS generations
	nix-env --list-generations |& nom
