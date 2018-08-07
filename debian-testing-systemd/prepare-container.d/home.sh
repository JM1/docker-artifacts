#!/bin/sh

if [ -n "$DEVIL_HOME" ]; then
    chown devil.devil "$DEVIL_HOME"
    usermod --home "$DEVIL_HOME" devil
fi
