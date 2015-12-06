# You can set following options in your .zshrc

# OS detection
[[ -n "${OS}" ]] || OS=$(uname)

# Symbol foreground color
SYMBOL_FG=%F{7}
# Symbol background color
SYMBOL_BG=%K{63}
# Symbol arrow foreground color
SYMBOL_ARROW=%F{63}

# background color
BG_COLOR_BASE03=%K{8}
# same
BG_COLOR_BASE02=%K{0}
BG_COLOR_BLACK0=%K{0}

BG_COLOR_BASE01=%K{10}
BG_COLOR_BASE00=%K{11}
BG_COLOR_BASE0=%K{12}
BG_COLOR_BASE1=%K{14}
BG_COLOR_GREY=%K{239}

# same
BG_COLOR_BASE2=%K{7}
BG_COLOR_WHITE7=%K{7}

BG_COLOR_BASE3=%K{15}
BG_COLOR_SKIN=%K{9}
BG_COLOR_YELLOW=%K{3}
BG_COLOR_ORANGE=%K{1}
BG_COLOR_RED=%K{9}
BG_COLOR_MAGENTA=%K{5}
BG_COLOR_VIOLET=%K{13}
BG_COLOR_BLUE=%K{32}
BG_COLOR_CYAN=%K{4}
BG_COLOR_GREEN=%K{2}

# foreground color
FG_COLOR_BASE03=%F{8}
# same
FG_COLOR_BASE02=%F{0}
FG_COLOR_BLACK0=%F{0}

FG_COLOR_BASE01=%F{10}
FG_COLOR_BASE00=%F{11}
FG_COLOR_BASE0=%F{12}
FG_COLOR_BASE1=%F{14}
# same
FG_COLOR_BASE2=%F{7} # White
FG_COLOR_WHITE7=%F{7}

FG_COLOR_GREY=%F{239}

FG_COLOR_BASE3=%F{15}
FG_COLOR_SKIN=%F{9}
FG_COLOR_YELLOW=%F{3}
FG_COLOR_ORANGE=%F{1}
FG_COLOR_RED=%F{9}
FG_COLOR_MAGENTA=%F{5}
FG_COLOR_VIOLET=%F{13}
FG_COLOR_BLUE=%F{32}
FG_COLOR_CYAN=%F{4}
FG_COLOR_GREEN=%F{2}

# BUG:: change it later
if [ $OS = "Darwin" ]; then
	local LOGO=""
else
	local LOGO=""
fi

# reset color
local RESET_COLOR=%f%k%b
local RESET=%{$RESET_COLOR%}
local RETURN_CODE="%(?..$FG_COLOR_RED%? ↵$RESET)"
local ARROW_SYMBOL=''
local ZSH_TIME=%D{%H:%M}
local PADDING=' '

GIT_DIRTY_COLOR=%F{196}
GIT_CLEAN_COLOR=%F{118}
GIT_PROMPT_INFO=%F{012}

ZSH_THEME_GIT_PROMPT_PREFIX="  "
ZSH_THEME_GIT_PROMPT_SUFFIX="$GIT_PROMPT_INFO"
ZSH_THEME_GIT_PROMPT_DIRTY=" $GIT_DIRTY_COLOR✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" $GIT_CLEAN_COLOR✔"

ZSH_THEME_GIT_PROMPT_ADDED="%F{082}✚%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{166}✹%f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{160}✖%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{220]➜%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{082]═%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{190]✭%f"

# option defaults
[[ -n "$ZSH_POWERLINE_SHOW_USER" ]]             || ZSH_POWERLINE_SHOW_USER=true
[[ -n "$ZSH_POWERLINE_SHOW_IP" ]]               || ZSH_POWERLINE_SHOW_IP=true
[[ -n "$ZSH_POWERLINE_SHOW_OS" ]]               || ZSH_POWERLINE_SHOW_OS=true
[[ -n "$ZSH_POWERLINE_SHOW_TIME" ]]             || ZSH_POWERLINE_SHOW_TIME=false
[[ -n "$ZSH_POWERLINE_SINGLE_LINE" ]]           || ZSH_POWERLINE_SINGLE_LINE=false
[[ -n "$ZSH_POWERLINE_SHOW_GIT_STATUS" ]]       || ZSH_POWERLINE_SHOW_GIT_STATUS=true
[[ -n "$ZSH_POWERLINE_SHOW_GIT_BRANCH_ONLY" ]]  || ZSH_POWERLINE_SHOW_GIT_BRANCH_ONLY=false
[[ -n "$ZSH_POWERLINE_SHOW_RETURN_CODE" ]]      || ZSH_POWERLINE_SHOW_RETURN_CODE=true
[[ -n "$ZSH_POWERLINE_DIRECTORY_DEPTH" ]]       || ZSH_POWERLINE_DIRECTORY_DEPTH=2

# a new line before prompt
PROMPT="
${FG_COLOR_BASE0}${BG_COLOR_BASE3}"

# OS logo followed by an arrow symbol
if [ $ZSH_POWERLINE_SHOW_OS = true ]; then
    PROMPT="${PROMPT}${SYMBOL_FG}${SYMBOL_BG}${PADDING}${LOGO}"
    PROMPT="${PROMPT} ${SYMBOL_ARROW}${BG_COLOR_BLUE}${ARROW_SYMBOL}"
    PADDING=' '
fi


# username
if [ $ZSH_POWERLINE_SHOW_USER = true ]; then
    local USER="%n"
    PROMPT="${PROMPT}${FG_COLOR_WHITE7}${BG_COLOR_BLUE}${PADDING}${USER}"
    PROMPT="${PROMPT} ${FG_COLOR_BLUE}${BG_COLOR_CYAN}${ARROW_SYMBOL}"
    PADDING=' '
fi

# hostname
if [ $ZSH_POWERLINE_SHOW_IP = true ]; then
    if [ "$(echo $IP | grep 200)" = "" ]; then
    IP=`curl -si --max-time 2 http://ipecho.net/plain`
        # no network connection, use hostname
        IP="%m"
    else
        # replace dot by dash
        IP=`echo -n $IP | tail -n 1 | sed "s/\./-/g"`
    fi
#	if [ $ZSH_POWERLINE_SHOW_USER = true ]; then
#		PROMPT="${PROMPT}${FG_COLOR_GREEN}${BG_COLOR_BASE3} at"
#	fi
    PROMPT="${PROMPT}${FG_COLOR_WHITE7}${BG_COLOR_CYAN}${PADDING}${IP}"
    PADDING=' '
fi

# arrow symbol for username and ip/host
if [ $ZSH_POWERLINE_SHOW_USER = true ] || [ $ZSH_POWERLINE_SHOW_IP = true ]; then
    if [ $ZSH_POWERLINE_SHOW_TIME = true ]; then
        PROMPT="${PROMPT} ${FG_COLOR_CYAN}${BG_COLOR_BASE01}${ARROW_SYMBOL}"
    else
        PROMPT="${PROMPT} ${FG_COLOR_CYAN}${BG_COLOR_GREY}${ARROW_SYMBOL}"
    fi
fi

# datetime
 if [ $ZSH_POWERLINE_SHOW_TIME = true ]; then
 	PROMPT="${PROMPT}${FG_COLOR_BASE3}${BG_COLOR_BASE01}${PADDING}${ZSH_TIME}"
 	PROMPT="${PROMPT} ${FG_COLOR_BASE01}${BG_COLOR_GREY}${ARROW_SYMBOL}"
 	PADDING=' '
 fi

# current directory (%E hightline all line to end)
DIRECOTORY_DEPTH="%${ZSH_POWERLINE_DIRECTORY_DEPTH}~"
PROMPT="${PROMPT}${FG_COLOR_WHITE7}${BG_COLOR_GREY} ${DIRECOTORY_DEPTH}"
PROMPT="${PROMPT} ${FG_COLOR_GREY}${BG_COLOR_BASE03}${ARROW_SYMBOL}"

PROMPT="${PROMPT}${FG_COLOR_WHITE7}${BG_COLOR_BASE03}"

# show git status
if [ $ZSH_POWERLINE_SHOW_GIT_BRANCH_ONLY = true ]; then
	# get git branch function
	git_branch() {
		git rev-parse --git-dir > /dev/null 2>&1
		if [ "$?" = "0" ]; then
			BRANCH=$(git branch | grep '*' | cut -d' ' -f2-)
			echo ${ZSH_THEME_GIT_PROMPT_PREFIX}${BRANCH}
		fi
	}
	PROMPT="${PROMPT}"'$(git_branch)'
elif [ $ZSH_POWERLINE_SHOW_GIT_STATUS = true ]; then
	PROMPT="${PROMPT}"'$(git_prompt_info)'
fi

# single line or double lines
if [ $ZSH_POWERLINE_SINGLE_LINE = false ]; then
    PROMPT="${PROMPT} ${RESET}${FG_COLOR_BASE03}${ARROW_SYMBOL}
  ${RESET}${FG_COLOR_BASE02}${ARROW_SYMBOL}"
else
	PROMPT="${PROMPT} ${RESET}${FG_COLOR_BASE02}${ARROW_SYMBOL}"
fi

# reset
PROMPT="$PROMPT ${RESET} "

if [ $ZSH_POWERLINE_SHOW_RETURN_CODE = true ]; then
	RPROMPT="${RETURN_CODE}"
fi

