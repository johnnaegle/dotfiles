if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export EDITOR='sublw'

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash  ]; then
  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

[[ $- == *i* ]]   &&   . ~/.git-prompt.sh

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


# autocreate aliases for all machines in your ssh/config
alias machine_list="cat ~/.ssh/config | egrep '^Host' | grep -v '\*' | cut -d ' ' -f 2"
SSH=ssh
for MACHINE in `machine_list`
do
    alias $MACHINE="TERM=xterm $SSH $MACHINE"
done


alias ressh='cd ~/code/code && bundle exec rake util:generate_sshconfig'
_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh
complete -F _complete_ssh_hosts csshx
complete -F _complete_ssh_hosts sftp

# set max open files per process to 1024
# https://superuser.com/questions/433746/is-there-a-fix-for-the-too-many-open-files-in-system-error-on-os-x-10-7-1
ulimit -n 1024


# Clears out the adobe flash player cache so I can watch the NBC olympic stream
# which  you can for 30 minutes before being kickbanned
rm -rf  ~/Library/Caches/Adobe/Flash\ Player/
rm -rf ~/Library/Preferences/Macromedia/
