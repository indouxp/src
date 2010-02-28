#
#	ID			:.prompt
#	EXPLANATION	:プロンプトのセッティング
#
#	CREATE		:20081005
#	UPDATE		:20090114
#
#	$Header: /mnt/share/lib/cvs/src/sh/prompt.sh,v 1.2 2009-04-26 08:26:56 indou Exp $
#

Prefix="\033[01;"
Suffix="m"

Black=30
Red=31
Green=32
Yellow=33
Blue=34
Magenta=35
Cyan=36
White=37
_Black=40
_Red=41
_Green=42
_Yellow=43
_Blue=44
_Magenta=45
_Cyan=46
_White=47

NORMAL="\033[00m"

BLACK=${Prefix?}${Black:?}${Suffix?}
RED=${Prefix?}${Red:?}${Suffix?}
GREEN=${Prefix?}${Green:?}${Suffix?}
YELLOW=${Prefix?}${Yellow:?}${Suffix?}
BLUE=${Prefix?}${Blue:?}${Suffix?}
MAGENTA=${Prefix?}${Magenta:?}${Suffix?}
CYAN=${Prefix?}${Cyan:?}${Suffix?}
WHITE=${Prefix?}${White:?}${Suffix?}
_BLACK=${Prefix?}${_Black:?}${Suffix?}
_RED=${Prefix?}${_Red:?}${Suffix?}
_GREEN=${Prefix?}${_Green:?}${Suffix?}
_YELLOW=${Prefix?}${_Yellow:?}${Suffix?}
_BLUE=${Prefix?}${_Blue:?}${Suffix?}
_MAGENTA=${Prefix?}${_Magenta:?}${Suffix?}
_CYAN=${Prefix?}${_Cyan:?}${Suffix?}
_WHITE=${Prefix?}${_White:?}${Suffix?}

getPrompt() {
    case `date '+%M'` in
    0[0-9]|1[0-5])
    	PROMPT_M="${RED}"
        ;;
    *)
        PROMPT_M=""
        ;;
    esac
    export PROMPT_M

    case `date '+%H'` in
    0[0-6])
        PROMPT_HMS="${RED}"
        ;;
    0[7-9]|1[0-1])
        PROMPT_HMS="${BLUE}"
        ;;
    12)
        PROMPT_HMS=${MAGENTA}
        ;;
    1[3-7])
        PROMPT_HMS=${BLUE}
        ;;
    1[8-9]|20)
        PROMPT_HMS=${CYAN}
        ;;
    2[1-3])
        PROMPT_HMS=${RED}
        ;;
    *)
        PROMPT_HMS=${BLACK}
        ;;
    esac
    export PROMPT_HMS
    #echo -en "${_color?}`date '+%m%d %H%M%S'`${NORMAL?} "
}
PROMPT_COMMAND=getPrompt
if [ _`uname` = _SunOS ]; then
    IdNo=`/usr/xpg4/bin/id -u`
else
    IdNo=`id -u`
fi
case ${IdNo:?} in
0)
	PS1="\$(echo -en \${PROMPT_HMS:?})\$(date '+%y%m%d %H')\$(echo -en \${PROMPT_M?})\$(date '+%M%S:')${RED:?}\u${NORMAL:?}${BLACK:?}@${NORMAL:?}${_RED:?}\h${NORMAL:?}:${GREEN:?}\W${NORMAL:?}# "
	;;	
*)
	PS1="\$(echo -en \${PROMPT_HMS:?})\$(date '+%y%m%d %H')\$(echo -en \${PROMPT_M?})\$(date '+%M%S:')${GREEN:?}\u${NORMAL:?}${BLACK:?}@${NORMAL:?}${_RED:?}\h${NORMAL:?}:${GREEN:?}\W${NORMAL:?}$ "
	;;	
esac

