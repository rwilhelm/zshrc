#!/usr/bin/env zsh
# echo ". zlogout"

# See: man -P 'less -p STARTUP/SHUTDOWN\ FILES' zsh

# When  a  login  shell  exits,  the  files  $ZDOTDIR/.zlogout  and  then
# /etc/zlogout  are  read.  This happens with either an explicit exit via
# the exit or logout commands, or an implicit exit by reading end-of-file
# from  the  terminal.   However, if the shell terminates due to exec'ing
# another process, the  logout  files  are  not  read.
