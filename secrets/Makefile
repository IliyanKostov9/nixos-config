## DEFAULT ENCRYPTION: age

SECRET_FILE ?= env_vars
USER ?= $(shell whoami)

.PHONY: unlock unlock-sys unlock-usr
unlock: unlock-sys unlock-usr
	@echo "Unlock secrets"

unlock-sys:
	sops system/secrets.yaml

unlock-usr:
	sops user/${USER}/${SECRET_FILE}.yaml

unlock-work:
	sops user/${USER}/work.yaml

.PHONY: print 
print:
	sops -d  "${SECRET_FILE}.yaml"

.PHONY: setup
setup:
	mkdir -p ~/.config/sops/age
	age-keygen -o ~/.config/sops/age/keys.txt
	echo -e 'Please add this public key: $(shell age-keygen -y ~/.config/sops/age/keys.txt) into .soaps.yaml\n\n==============\nPress ENTER to continue...'
	read
	sudo mkdir -p /var/lib/sops-nix
	sudo sh -c 'echo "AGE-SECRET-KEY-1V4YXNXT..." > /var/lib/sops-nix/key.txt'
	sudo chown ${USER}:users /var/lib/sops-nix/key.txt
	sudo chmod 600 /var/lib/sops-nix/key.txt
	echo "Setup completed! Now create secrets.yaml file by using 'make unlock SECRET_FILE=my_secret_file'"


