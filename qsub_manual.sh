#!/bin/bash
#$ -q hoffmangroup
#$ -cwd

# verbose failures
set -o nounset -o pipefail -o errexit

TSTART=$1
TEND=$2
shift
shift

set +o errexit
for i in `seq $TSTART $TEND`; do
    export SGE_TASK_ID=$i
    $@
    if [ "$?" -ne "0" ]; then
        echo "subtask $i failed"
    fi
done
