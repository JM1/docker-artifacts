#!/bin/sh

cat << EOF >> /etc/profile.d/display.sh
#!/bin/sh
# (2018) WEARENOTALONE

$([ -n "$DISPLAY" ] && echo "export DISPLAY=$DISPLAY")

EOF
