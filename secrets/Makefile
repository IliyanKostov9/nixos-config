SECRET_FILE ?= zprofile
GPG_KEY_ID ?= placeholder

.PHONY: unlock
unlock:
	nix-shell -p sops --run "sops ${SECRET_FILE}.yaml"

.PHONY: setup
setup:
	gpg --export-secret-keys ${GPG_KEY_ID} > ~/Downloads/privkey.gpg
	sudo mkdir /var/lib/sops
	sudo chmod 700 /var/lib/sops
	sudo mv ~/Downloads/privkey.gpg /var/lib/sops/
