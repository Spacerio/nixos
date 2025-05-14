#!/usr/bin/env bash
sudo nixos-rebuild switch --flake .

if [[ -d ~/.nixos ]]; then
	echo ""
fi
