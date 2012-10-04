# =============================
#
# Loaded when wake up the shell that is called by UID.
# set the settings is always enalble, even if shellscript(?)
#
# =============================

if [ -f ~/.dir_colors ]; then
    eval `dircolors ~/.dir_colors -b`
fi

