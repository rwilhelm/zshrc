export EDITOR='subl -n' # atom -n # vim -p # mate -w # subl -n
# select and export EDITOR variable
editor () {
    case $1 in
        subl)
        whence subl3 && alias subl=subl3
        EDITOR='subl -n'
        ;;
        atom)
        EDITOR='atom -n'
        ;;
        vim)
        EDITOR='vim -p'
        ;;
        mate)
        EDITOR='mate -w'
        ;;
        # *)
        # EDITOR='atom -n'
        # ;;
    esac
    export EDITOR
    echo $EDITOR
}
