#!/bin/bash

for F in xst.s3 xst.s6 xst.v4 xst.v5 xst.v6
do
    if [ -f $F/Clean.sh ]; then
       ( cd $F; ./Clean.sh )
    fi
done
