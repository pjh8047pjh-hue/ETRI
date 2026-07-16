#!/bin/csh -f

set DIRS="xst.s3 xst.s6"

foreach F ( $DIRS )
    if ( -e $F/Clean.csh ) then
       ( cd $F; ./Clean.csh )
    endif
end
