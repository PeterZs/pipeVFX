#!/bin/sh


_runAlias(){
    local cur
    cur=$2
    if type run >&/dev/null; then
            COMPREPLY=( "${COMPREPLY[@]}" $(
            compgen -W "$( alias | grep pipe.apps | cut -d' ' -f2 | cut -d= -f1 \
                            | sort -u )" -- "$cur" ) )
    fi
}


complete -o bashdefault -o default -o nospace -F _runAlias run 2>/dev/null \
	|| complete -o default -o nospace -F _runAlias run 




_alias(){
    local cur
    cur=$2
    COMPREPLY=( "${COMPREPLY[@]}" $(
    compgen -W "$( alias | cut -d' ' -f2 | cut -d= -f1 \
                    | sort -u )" -- "$cur" ) )
}
complete -o bashdefault -o default -o nospace -F _alias alias 2>/dev/null \
	|| complete -o default -o nospace -F _alias alias 



#_maya(){
#    local cur
#    cur=$2
#    if type maya >&/dev/null; then
#            COMPREPLY=( "${COMPREPLY[@]}" $(
#            compgen -W "$( maya --help 2>&1 | grep '^-' | cut -d' ' -f1 \
#                            | sort -u )" -- "$cur" ) )
#    fi
#}
#complete -o bashdefault -o default -o nospace -F _maya maya 2>/dev/null \
#	|| complete -o default -o nospace -F _maya maya 

