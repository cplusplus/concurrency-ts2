#!/bin/bash

# This script checks the results of the LaTeX run.

failed=0

function fail() {

    # echo "::error file=app.js,line=10,col=15::Something went wrong"

    ! sed 's/^\(.\+\.tex\):/file=\1::/;s/^/::error /' | grep .
}


# Discover "Overfull \[hv]box" and "Reference ... undefined" messages from LaTeX.
sed -n '/\.tex/{s/^.*\/\([-a-z0-9]\+\.tex\).*$/\1/;h};
/Overfull [\\][hv]box\|LaTeX Warning..Reference/{x;p;x;p}' ts.log |
    sed '/^.\+\.tex$/{N;s/\n/:/}' | fail || failed=1


exit $failed
