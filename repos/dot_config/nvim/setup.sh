#!/bin/sh
dirname=$(cd $(dirname $0);pwd)

cd ~/.config
ln -s ${dirname} .

mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
