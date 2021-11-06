#!/bin/bash

dest=~/
current=$(cd $(dirname $0);pwd)
source=$current/repos

files=$(ls $source)
if [ $# -ne 0 ]; then
  files="$@"
fi

for file in $files
do
  file=`basename $file`

  if [ "${file}" = "nvim" ]; then
    ${current}/repos/dot_config/nvim/setup.sh
    continue
  fi

  if [ "$file" = "." -o "$file" = ".." -o ! -f "$source/$file" ]; then
    continue
  fi

  if [ ! -L $dest/$file ]; then
    echo "######### $file ###########"

    if [ -f ~/.$file ]; then
      cp ~/.$file $current/org/$file
      rm ~/.$file
    fi
    ln -s $source/$file $dest/.$file
  fi
done





