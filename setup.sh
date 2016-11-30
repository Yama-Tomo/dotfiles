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
  if [ "$file" = "." -o "$file" = ".." ]; then
    continue
  fi

  if [ ! -f "$source/$file" ]; then
    continue
  fi
  
  #echo $file
  #continue

  if [ ! -L $dest/$file ]; then
    echo "######### $file ###########"

    if [ -f ~/.$file ]; then
      cp ~/.$file $current/org/$file
      rm ~/.$file
    fi
    ln -s $source/$file $dest/.$file
  fi
done





