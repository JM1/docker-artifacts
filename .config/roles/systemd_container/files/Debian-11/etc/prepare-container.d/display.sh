#!/bin/sh

cat << EOF >> /etc/profile.d/display.sh
#!/bin/sh
# 2018-2021 Jakob Meng, <jakobmeng@web.de>

$([ -n "$DISPLAY" ] && echo "export DISPLAY=$DISPLAY")

EOF
