.PHONY: update
update:
	home-manager switch --flake .#ikostov2
.PHONY: clean
clean:
	nix-collect-garbage -d
