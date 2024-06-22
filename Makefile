.PHONY: update
update:
	home-manager switch --flake .#ikostov2 --show-trace
	
.PHONY: update-sys
update-sys:
	sudo nixos-rebuild switch --flake .#ikostov2 --show-trace
	
.PHONY: flake-check
flake-check:
	nix flake check

.PHONY: clean
clean:
	nix-collect-garbage -d
