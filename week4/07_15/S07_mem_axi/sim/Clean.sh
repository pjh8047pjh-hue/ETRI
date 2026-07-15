#!/bin/sh

for F in modelsim
do
    if [ -f $F/Clean.sh ]; then
       ( cd $F; ./Clean.sh )
    fi
done
