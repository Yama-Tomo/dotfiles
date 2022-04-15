#!/bin/sh

current=$(cd $(dirname $0);pwd)
name=$(basename $current)

cd ~/.config
if [ -e $name ]; then
  mv $name $current/../../org/
fi
ln -s $current .
