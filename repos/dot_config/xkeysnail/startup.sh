#!/bin/sh

# visudo などでノンパスで xkeysnail を実行できるようにしておく必要があります
if [ ! -z "$(which xkeysnail)" ]; then
  xhost +SI:localuser:root
  sudo DISPLAY=$DISPLAY xkeysnail --watch ${HOME}/.config/xkeysnail/config.py >/dev/null
fi
