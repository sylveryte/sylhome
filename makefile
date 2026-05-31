CONFIGPATH=$(CURDIR)/.config
HOST_CONFIGPATH=$(HOME)/.config

CONFIGS := \
			foot \
			nvim \
			yazi \
			fuzzel \
			ghostty \
			niri \
			systemd \
			waybar \
			sxiv \
			imv \
			helix \
			kitty \
			ytfzf \
			zathura \
			mako


.PHONY: link builddevbox setupdevbox setup

link:
	mkdir -p $(HOST_CONFIGPATH)
	for cfg in $(CONFIGS); do \
			ln -sfn ${CONFIGPATH}/$$cfg $(HOST_CONFIGPATH)/$$cfg; \
	done

builddevbox:
	DEVHOME=$(CURDIR) podman build --group-add keep-groups -t devbox .

setupdevbox:
	distrobox-create --image devbox --home $(CURDIR) devbox
	distrobox enter devbox

setup: link builddevbox setupdevbox
