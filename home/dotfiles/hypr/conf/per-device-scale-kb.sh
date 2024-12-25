#!/usr/bin/env bash
HOSTNAME=$(hostname)

if [[ "$HOSTNAME" == "sp7" ]]; then
    hyprctl keyword monitor ,prefered,auto,2
    hyprctl keyword input:kb_layout fr
elif [[ "$HOSTNAME" == "gigaos" ]]; then
    hyprctl keyword monitor ,prefered,auto,1.2
    hyprctl keyword input:kb_layout es
fi
