# (2020) WEARENOTALONE
# Use Ccache, a fast C/C++ compiler cache, to speed up recompilation by caching the result
# of previous compilations and detecting when the same compilation is being done again.
# Ref.: man ccache
if [ -d "/usr/lib/ccache" ]; then
    PATH="/usr/lib/ccache:$PATH"
fi
