#!/bin/bash
#
# Only including a shebang to trigger Sublime Text to use shell syntax highlighting
#
# Copyright 2006-2015 Joseph Block <jpb@unixorn.net>
#
# BSD licensed, see LICENSE.txt

# yes, these tests are ugly. They do however, work.

export CVS_RSH=ssh

alias historysummary="history | awk '{a[\$2]++} END{for(i in a){printf \"%5d\t%s\n\",a[i],i}}' | sort -rn | head"

# if [ -x /usr/local/bin/vim ]; then
#     alias vim="/usr/local/bin/vim"
#     alias vi="/usr/local/bin/vim"
#     export EDITOR="/usr/local/bin/vim"
# fi

export VISUAL=${EDITOR}

# Clean up files that have the wrong line endings
alias mac2unix="tr '\015' '\012'"
alias unix2mac="tr '\012' '\015'"

# A couple of different external IP lookups depending on which is down.
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias myip2="curl -s icanhazip.com"

# Show laptop's IP addresses
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# SSH stuff
# Pass our credentials by default # FIXME really? yes? sure?
# alias ssh="ssh -A"

alias scp_no_hostchecks="scp -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
alias ssh_no_hostchecks="ssh -A -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

# Strip color codes from commands that insist on spewing them so we can
# pipe them into files cleanly
alias stripcolors='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'

# On the rare occasions I don't want to continue a download I can always
# delete the incomplete fragment explicitly. I usually just want to
# complete it.
alias wget="wget -c"

# Dump the last 20 history entries
alias zh="fc -l -d -D"

alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
