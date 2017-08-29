#!/bin/bash

# verbose failures
set -o nounset -o pipefail -o errexit

# For some reason python2 keeps on loading on top of python3, 
# and causes the library path to get messed up. This fixes that.
module unload python3
module load python3

while true; do
    clear
    top -b -n 1 | grep fnguyen
    df /tmp
    sleep 30
done
