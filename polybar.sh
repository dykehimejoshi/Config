#!/usr/bin/env sh

polybar-msg cmd quit

polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched"
