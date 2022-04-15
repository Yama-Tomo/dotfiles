#!/bin/sh
dirname=$(cd $(dirname $0);pwd)

cd ~/.config
ln -s ${dirname} .

