TARGETS_IN:=$(sort $(dir $(wildcard */)))
TARGETS= $(TARGETS_IN:/=.x)
TARGETS:=$(filter-out media.x,$(TARGETS))

help:
	@egrep '^[^ ]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

stow: $(TARGETS) ## Stow all folders

%.x:
	stow $(basename $@)

UNAME:=$(shell uname -m)


apt: # apt_docker apt_node ## Install packages
	sudo apt-get update --fix-missing
	sudo snap install spotify
	sudo snap install --classic slack
	sudo snap install zoom-client
	sudo snap install keepassxc
	sudo snap install telegram-desktop
	sudo apt install -q -y $$(cat packages.txt  | grep -v '^#' | paste -s)

other-peoples-repos:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo wget -O /usr/share/keyrings/riot-im-archive-keyring.gpg https://packages.riot.im/debian/riot-im-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/riot-im-archive-keyring.gpg] https://packages.riot.im/debian/ default main" | sudo tee /etc/apt/sources.list.d/riot-im.list

omzsh:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

.PHONY: apt bootstrap fix-origin
