# Francis Nguyen's custom .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

unset SSH_ASKPASS

# Exports
#export PATH=/scratch/bin/anaconda2/bin:$PATH
export PATH=$HOME/python/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/hdf5-1.8.17/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/.local/hdf5-1.8.17/lib:$LD_LIBRARY_PATH
export PS1='(\!) \t \[\033[01;34m\]\h\[\033[00m\]:\w$ '
export TKSRC="${HOME}/.local/bin"
export EDITOR=vim
export HDF5_DIR=${HOME}/.local/hdf5-1.8.17
# the login sequence on download.q is weird and conflicts w/ the python3 module
unset PYTHONPATH 
#export PYTHONPATH='/mnt/work1/users/home2/fnguyen/python'
#export PYTHONPATH=/scratch/bin/anaconda2/bin/python

# Modules
#module load python/2.7
#module load python3
#module load R/3.3.0
module load bedtools/2.23.0
module load emacs/24.3
#module load gcc/6.2.0
DIR_TMP_FILE=${HOME}/.tmp_dir_chng.txt

# General use
alias ll='ls -alh --color'                  # Preferred 'ls'
alias l='ls -ah --color'                    # non-list version of the above
alias halp='top -b | head -n 10'            # halp:     What's throttling this machine?
alias rcp='rsync -avP'                      # Rsync cp
alias ..="cd .."                            # Go up one directory
alias ...="cd ../../"                       # Go up two directories
alias .2="cd ../../"                        # Alternate go up two directories
alias .3="cd ../../../"                     # Go up three directories
alias .4="cd ../../../../"                  # Go up four directories
alias -- -="cd -"                           # Go to the previous directory
alias tmux='TERM=xterm-256color tmux'       # Preferred 'tmux' implementation
alias emacs='emacs -nw'                     # Preferred 'emacs' implementation
alias pmine="top -b -n 1 | grep fnguyen"    # pmine:    What's the CPU/MEM/Status of all of my processes on this machine?
alias pt="${HOME}/.local/bin/pytest"        # pt:       Run pytest
alias cln="echo *.e* *.o* \"Y/N\"; read is_ok; if [ $is_ok -eq \"Y\" ]; then rm *.e* *.o*; fi"  # rm *.e* *.o* with confirmation
alias qfind="find . -name "                 # qfind:    Quickly search for file
alias gst="git status"                      # gst: Get git status

# SGE submission
alias qr="qrsh -q hoffmangroup -now no -l h_vmem=8G -l mem_requested=8G"
alias q="qrsh -q hoffmangroup -now no"
alias qm='qrsh -q hoffmangroup -now no -l h_vmem=${M}G -l mem_requested=${M}G'
alias sv="pwd >${DIR_TMP_FILE}"
alias rl="while read i ; do echo \$i ; cd \$i ; done <${DIR_TMP_FILE}"
alias qst="qstat | sed 's/^/ /'"

# SGE stats
alias qavail="python3 ${HOME}/qavail.py"
alias qqueue="qstat -g c"
alias qmonitor="${HOME}/qmonitor.sh"
alias forensic="python3 ${HOME}/forensic.py"
#alias storage="cat /mnt/work1/users/hoffmangroup/storage_report"
alias storage="python3 ~/storage.py"
alias qstf="${HOME}/qstf.sh"                # qstf: Run qstat once per second
lastjob() { qacct -o `whoami` -j | tail -n 45 | grep "jobnumber" | awk '{print $2;}'; }
forensics() { qacct -j $1 | grep -B 9 -P "exit_status\\s+[1-9]"; }
#alias rl="cd $(< ${HOME}/tmp_dir_chng.txt)"

# Enable conda
#export PATH="/mnt/work1/users/home2/fnguyen/miniconda3/bin:$PATH"
#export PATH="/mnt/work1/users/home2/fnguyen/anaconda3/bin:$PATH"
. /mnt/work1/users/home2/fnguyen/anaconda3/etc/profile.d/conda.sh
#alias conda-py="source activate py-2.7.3; tput bel"

if [ "$HOSTNAME" != "mordor" ]; then
    # Also edit the bash history file location
    HISTFILE=${HOME}/bashhistory/${HOSTNAME}_$$.bash_history
    HISTSIZE=""
    HISTFILESIZE=""

    # Also fix the terminal colours
    export TERM=screen-256color

    # Finally, enable conda-py automatically
    conda activate py27

    tput bel    # Alarm when a qrsh host is grabbed
fi

#if [ ! -n "$TMUX" ]; then
#    # Remind me to commit stuff
#    git status ${HOME}/scProject/
#fi
