#!/usr/bin/env bash
current=$(hyprctl monitors | grep "active workspace" | sed 's/[^0-9]*\([0-9]*\).*/\1/')
total=10  # Set this to your total number of workspaces

if [[ "$1" == "next" && $current -lt total ]]; then
    next=$(( (current % total) + 1 ))
elif [[ "$1" == "prev" && $current -gt 1 ]]; then
    next=$(( (current + total - 2) % total + 1 ))
else
    exit 1
fi

hyprctl dispatch workspace $next
