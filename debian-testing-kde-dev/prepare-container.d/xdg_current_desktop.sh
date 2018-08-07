#!/bin/sh

if [ -n "$XDG_CURRENT_DESKTOP" ]; then
    echo "export XDG_CURRENT_DESKTOP=$XDG_CURRENT_DESKTOP" >> /etc/profile.d/xdg_current_desktop.sh || true
fi
