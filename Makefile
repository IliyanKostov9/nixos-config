HDD_PART := /dev/sdb1

##########################
# TARGET
# #######################

.PHONY: help
help:  ## help target to show available commands with information
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup label secure-boot
setup: label secure-boot

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

.PHONY: secure-boot-sign
secure-boot-sign:
	echo "Enrolling keys..."
	sudo sbctl enroll-keys --microsoft
	echo -e "Now you'll be rebooted again.\n\Finally after reboot type `bootctl status` to check if secure boot is signed\n\nPress ENTER to continue"
	read
	sudo reboot

.PHONY: home-update
home-update:  ## Build home configuration for default user
	home-manager switch --flake .#$(shell whoami) --show-trace --impure |& nom
	
.PHONY: sys-update
sys-update: ## Build system configuration for all hosts
	@if ! [ -z $(DEVICE) ]; then \
	 echo "Building $(DEVICE) system..."; \
	 sudo -v && sudo nixos-rebuild switch --flake .#$(DEVICE) --show-trace --impure |& nom; \
  else \
	  echo -e "DEVICE env variable is not set!\n========================\n\nChoose on what system to build for the following options:\n  1.personal-desktop\n  2.work-laptop\n----------------"; \
	  read -p "Choice: " choice; \
	  if [ "$$choice" = "1" ]; then \
            device="hosts-personal-desktop"; \
	  elif [ "$$choice" = "2" ]; then \
	    device="hosts-work-laptop"; \
	  else \
	    echo "Error: wrong choice!"; \
	    exit 1; \
	  fi; \
	 echo "Building $$device system..."; \
	 sudo -v && sudo nixos-rebuild switch --flake .#$$device --show-trace --impure |& nom; \
	fi

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
	nix store optimise

