#!/bin/csh -f

set DIRS="sim syn rtl"

foreach F ( $DIRS )
    if ( -e $F/Clean.csh ) then
       ( cd $F; ./Clean.csh )
    endif
end
