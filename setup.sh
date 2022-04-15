#!/bin/bash

# usage: ./setup.sh or ./setup.sh repos/bashrc repos/nvim ...

dest=~/
current=$(cd $(dirname $0);pwd)
source=$current/repos

paths=$(ls $source)
if [ $# -ne 0 ]; then
  paths="$@"
fi

for path in $paths
do
  name=$(basename $path)

  if [ -d $source/$name ]; then
    if [ -e $source/$name/setup.sh ]; then
      $source/$name/setup.sh
      echo "$name done."
    else
      echo 'warn: '$name' `setup.sh` not found'
    fi

    continue
  fi

  file=$name
  if [ "$file" = "." -o "$file" = ".." -o ! -f "$source/$file" ]; then
    continue
  fi

  if [ ! -L $dest/$file ]; then
    if [ -f ~/.$file ]; then
      cp ~/.$file $current/org/$file
      rm ~/.$file
    fi
    ln -s $source/$file $dest/.$file

    echo "$name done."
  fi
done
