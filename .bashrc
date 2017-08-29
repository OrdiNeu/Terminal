# Francis Nguyen's custom .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

unset SSH_ASKPASS

# Exports
#export PATH=/scratch/bin/anaconda2/bin:$PATH
export PATH=$HOME/python/bin:$PATH export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export PS1='(\!) \t \[\033[01;34m\]\h\[\033[00m\]:\w$ '
export TKSRC="${HOME}/.local/bin"
export EDITOR=vim
#export PYTHONPATH='/mnt/work1/users/home2/fnguyen/python'
#export PYTHONPATH=/scratch/bin/anaconda2/bin/python

# Modules
#module load python/2.7
#module load python3
module load R/3.3.0
module load bedtools/2.23.0
module load gcc/6.2.0
DIR_TMP_FILE=${HOME}/.tmp_dir_chng.txt

# General use
alias ll='ls -alh --color'
alias l='ls -ah --color'
alias halp='top -b | head -n 10'
alias rcp='rsync -avP'
alias ..="cd .."
alias -- -="cd -"
alias tmux='TERM=xterm-256color tmux'
alias pmine="top -b -n 1 | grep fnguyen"
alias pt="${HOME}/.local/bin/pytest"
alias cln="echo *.e* *.o* \"Y/N\"; read is_ok; if [ $is_ok -eq \"Y\" ]; then rm *.e* *.o*; fi"

# SGE submission
alias qr="qrsh -q hoffmangroup -now no -l h_vmem=8G -l mem_requested=8G"
alias q="qrsh -q hoffmangroup -now no"
alias qm='qrsh -q hoffmangroup -now no -l h_vmem=${M}G -l mem_requested=${M}G'
alias sv="pwd >${DIR_TMP_FILE}"
alias rl="while read i ; do echo \$i ; cd \$i ; done <${DIR_TMP_FILE}"
alias qst="qstat"

# SGE stats
alias qavail="python3 ${HOME}/qavail.py"
alias qqueue="qstat -g c"
alias qmonitor="${HOME}/qmonitor.sh"
alias forensic="python3 ${HOME}/forensic.py"
#alias storage="cat /mnt/work1/users/hoffmangroup/storage_report"
alias storage="python3 ~/storage.py"
forensics() { qacct -j $1 | grep -B 9 -P "exit_status\\s+[1-9]"; }
#alias rl="cd $(< ${HOME}/tmp_dir_chng.txt)"

# added by Miniconda3 4.3.11 installer
#export PATH="/mnt/work1/users/home2/fnguyen/miniconda3/bin:$PATH"
if [ "$HOSTNAME" != "mordor" ]; then
    tput bel    # Alarm when a qrsh host is grabbed
fi
