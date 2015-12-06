####################################
######## My zsh prompt ############# 
####################################

# You can set following options in your .zshrc

# OS detection
[[ -n "${OS}" ]] || OS=$(uname)

##########################
# THE COLORS. THE COLORS #
##########################

# Change these values to change color of any of the prompt elements
# Symbol foreground and background color
OS_LOGO_FG=7
OS_LOGO_BG=63

# The username forground and background color
USERNAME_FG=7
USERNAME_BG=32

# hostname foreground and background color
HOSTNAME_FG=7
HOSTNAME_BG=4

# time fg and bg
TIME_FG=7
TIME_BG=2

# directory fg and bg
DIRECOTORY_FG=7
DIRECOTORY_BG=239

# GIT prompt fg and bg
GIT_PROMPT_FG=7
GIT_PROMPT_BG=0

# Random symbol prompt fg and bg
RANDOM_SYMBOL_FG=1
RANDOM_SYMBOL_BG=7

# The colors for the git prompt %F denotes start using the following number
# as foreground color
GIT_DIRTY_COLOR=%F{196}
GIT_CLEAN_COLOR=%F{118}
GIT_PROMPT_INFO=%F{012}


############################
# VALUES of various fields #
############################

# Change this value to change how date-time is displa
local ZSH_TIME=%D{%H:%M}

# The seperator between the various prompt elements
# add more symbols here and change the value of the seperator
local ARROW_SYMBOL=''
local SEPERATOR=${ARROW_SYMBOL}

# Modify these to get different symbols for various git statuses
ZSH_THEME_GIT_PROMPT_PREFIX="  "
ZSH_THEME_GIT_PROMPT_SUFFIX="$GIT_PROMPT_INFO"
ZSH_THEME_GIT_PROMPT_DIRTY=" $GIT_DIRTY_COLOR✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" $GIT_CLEAN_COLOR✔"

# More git statuses
ZSH_THEME_GIT_PROMPT_ADDED="%F{082}✚%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{166}✹%f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{160}✖%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{220]➜%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{082]═%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{190]✭%f"

# Set the value of the logo here (Replace 'Linux' with the tux icon)
if [ $OS = "Darwin" ]; then
	local LOGO=""
else
	local LOGO=""
fi

# option defaults
# Probably in the future I will add ordering to them 
# so one can select the order in which the elements of the prompt
# are displayed
[[ -n "$SHOW_USER" ]]             || SHOW_USER=true
[[ -n "$SHOW_IP" ]]               || SHOW_IP=true
[[ -n "$SHOW_OS" ]]               || SHOW_OS=true
[[ -n "$SHOW_TIME" ]]             || SHOW_TIME=false
[[ -n "$SINGLE_LINE" ]]           || SINGLE_LINE=false
[[ -n "$SHOW_GIT_STATUS" ]]       || SHOW_GIT_STATUS=true
[[ -n "$SHOW_GIT_BRANCH" ]]       || SHOW_GIT_BRANCH=false
[[ -n "$SHOW_RETURN_CODE" ]]      || SHOW_RETURN_CODE=true
[[ -n "$DIRECTORY_DEPTH" ]]       || DIRECTORY_DEPTH=4

# select a prompt symbol for this terminal randomly 
# (Go ahead add more symbols to this list)
sym_list=(ϗ δ ζ ξ χ λ ϟ ϑ Σ λ Ɲ Ħ ƍ Ξ Θ Ϡ Ϟ)
sym_len=${#sym_list[@]}
# The random symbol that will be displayed
sym_now=${sym_list[$((${RANDOM} % sym_len))]}

# reset color
local RESET_COLOR=%f%k%b
local RESET=%{$RESET_COLOR%}
local RETURN_CODE="%(?..$FG_COLOR_RED%? ↵$RESET)"
local PADDING=' '

#########################
# Generating the prompt #
#########################

# a new line before prompt
PROMPT="
${FG_COLOR_BASE0}${BG_COLOR_BASE3}"

# Now the following lines contain the logic for generating the prompt based
# on the values that are set in the above section.

# Keeping track of which element will go first 
# accordingly display or omit the seperator 
local FIRST=true

# OS logo followed by an arrow symbol
if [ $SHOW_OS = true ]; then
    # Use the predefined logo and it's color and append it to the prompt
    PROMPT="${PROMPT}%F{${OS_LOGO_FG}}%K{${OS_LOGO_BG}}${PADDING}${LOGO}"
    # defining what cshould be the color of the foreground of the seperator
    # i.e. same as the background color of the logo
    PROMPT="${PROMPT} %F{${OS_LOGO_BG}}"
    FIRST=false
fi


# USERNAME
if [ $SHOW_USER = true ]; then
    # append the seperator symbol only if it's not the first emenent
    if [ $FIRST = false ]
    then
        PROMPT="${PROMPT}%K{${USERNAME_BG}}${SEPERATOR}" 
    fi

    local USER="%n"
    # use the predefined username config
    PROMPT="${PROMPT}%F{${USERNAME_FG}}%K{${USERNAME_BG}}${PADDING}${USER}"
    # foreground color for the seperator
    PROMPT="${PROMPT} %F{${USERNAME_BG}}"
    FIRST=false
fi

# hostname
if [ $SHOW_IP = true ]; then
    # append the seperator symbol only if it's not the first emenent
    if [ $FIRST = false ]
    then
        PROMPT="${PROMPT}%K{${HOSTNAME_BG}}${SEPERATOR}" 
    fi
    
    if [ "$(echo $IP | grep 200)" = "" ]; then
        IP=`curl -si --max-time 2 http://ipecho.net/plain`
        # no network connection, use hostname
        IP="%m"
    else
        # replace dot by dash
        IP=`echo -n $IP | tail -n 1 | sed "s/\./-/g"`
    fi
    PROMPT="${PROMPT}%F{${HOSTNAME_FG}}%K{${HOSTNAME_BG}}${PADDING}${IP}"
    PROMPT="${PROMPT} %F{${HOSTNAME_BG}}"
    FIRST=false
fi

# datetime
if [ $SHOW_TIME = true ]; then
    if [ $FIRST = false ]
    then
        PROMPT="${PROMPT}%K{${TIME_BG}}${SEPERATOR}" 
    fi

    PROMPT="${PROMPT}%F{${TIME_FG}}%K{${TIME_BG}}${PADDING}${ZSH_TIME}"
    PROMPT="${PROMPT} %F{${TIME_BG}}"
    FIRST=false
fi


# a seperator
if [ $FIRST = false ]
then
    PROMPT="${PROMPT}%K{${DIRECOTORY_BG}}${SEPERATOR}" 
fi

# current directory
DIRECOTORY_DEPTH="%${DIRECTORY_DEPTH}~"
PROMPT="${PROMPT}%F{${DIRECOTORY_FG}}%K{${DIRECOTORY_BG}} ${DIRECOTORY_DEPTH}"
PROMPT="${PROMPT} %F{${DIRECOTORY_BG}}"


# GIT PROMPT DISPLAY
if [ $SHOW_GIT_BRANCH = true ] || [ $SHOW_GIT_STATUS = true ]
then
    PROMPT="${PROMPT}%K{${GIT_PROMPT_BG}}${SEPERATOR}"
    PROMPT="${PROMPT}%F{${GIT_PROMPT_FG}}"
fi

# show git status
if [ $SHOW_GIT_BRANCH = true ]; then
    # get git branch function
    git_branch() {
	git rev-parse --git-dir > /dev/null 2>&1
	if [ "$?" = "0" ]; then
            BRANCH=$(git branch | grep '*' | cut -d' ' -f2-)
            echo ${ZSH_THEME_GIT_PROMPT_PREFIX}${BRANCH}
	fi
    }
    PROMPT="${PROMPT}"'$(git_branch)'
elif [ $SHOW_GIT_STATUS = true ]; then
    PROMPT="${PROMPT}"'$(git_prompt_info)'
fi

if [ $SHOW_GIT_BRANCH = true ] || [ $SHOW_GIT_STATUS = true ]
then
    PROMPT="${PROMPT} %F{${GIT_PROMPT_BG}}"
fi


# single line or double lines
if [ $SINGLE_LINE = false ]; then
    PROMPT="${PROMPT} %k${SEPERATOR}
${RESET}%F{${RANDOM_SYMBOL_FG}}%K{${RANDOM_SYMBOL_BG}} ${sym_now} "
    PROMPT="${PROMPT}%k%F{${RANDOM_SYMBOL_BG}}${ARROW_SYMBOL}"
else
    PROMPT="${PROMPT} %k${SEPERATOR}"
fi


# reset
PROMPT="$PROMPT ${RESET} "

if [ $SHOW_RETURN_CODE = true ]; then
	RPROMPT="${RETURN_CODE}"
fi

