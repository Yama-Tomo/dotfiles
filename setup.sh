#!/bin/bash

dest=~/
current=$(cd $(dirname $0);pwd)
source=$current/repos

for file in $(ls $source -a )
do
  if [ "$file" = "." -o "$file" = ".." ]; then
    continue
  fi

  if [ ! -L $dest/$file ]; then
    echo "######### $file ###########"

    if [ -f ~/$file ]; then
      cp ~/$file $current/org
      rm ~/$file
    fi
    ln -s $source/$file $dest/$file
  fi
done





