.PHONY: update
update:
	home-manager switch --flake .#ikostov2 --show-trace
.PHONY: clean
clean:
	nix-collect-garbage -d
