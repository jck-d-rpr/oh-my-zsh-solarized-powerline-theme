####################################
######## My zsh prompt #############
####################################

# You can set following options in your .zshrc

# OS detection
[[ -n "${OS}" ]] || OS=$(uname)

# Path to the super_git_prompt
# You can comment it out if you don't want it
source ~/.oh-my-zsh/extra_plugins/zsh-git-prompt/zshrc.sh

##########################
# THE COLORS. THE COLORS #
##########################

# Change these values to change color of any of the prompt elements
# Symbol foreground and background color
OS_LOGO_FG=7
# 7
OS_LOGO_BG=63
# 63

# The username forground and background color
USERNAME_FG=7
# 7
USERNAME_BG=32
# 32

# hostname foreground and background color
HOSTNAME_FG=7
# 7
HOSTNAME_BG=4
# 4

# time fg and bg
TIME_FG=7
# 7
TIME_BG=2
# 2

# directory fg and bg
DIRECOTORY_FG=7
# 7
DIRECOTORY_BG=239
# 239

# GIT prompt fg and bg
GIT_PROMPT_FG=7
# 7
GIT_PROMPT_BG=8
# 0

# Random symbol prompt fg and bg
RANDOM_SYMBOL_FG=1
# 1
RANDOM_SYMBOL_BG=7
# 7

# The colors for the git prompt %F denotes start using the following number
# as foreground color
GIT_DIRTY_COLOR=%F{196}
GIT_CLEAN_COLOR=%F{118}
GIT_PROMPT_INFO=%F{012}


############################
# VALUES of various fields #
############################

# Change this value to change how date-time is displayed
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

# Set the value of the logo here
# TODO
if [ $OS = "Darwin" ]; then
	local LOGO=""
else
	local LOGO=""
fi

# option defaults
# Probably in the future I will add ordering to them
# so one can select the order in which the elements of the prompt
# are displayed
[[ -n "$SHOW_IP" ]]               || SHOW_IP=true
[[ -n "$SINGLE_LINE" ]]           || SINGLE_LINE=false

# Various git prompts (listed in order of prefrence)
[[ -n "$SHOW_GIT_STATUS" ]]       || SHOW_GIT_STATUS=false
[[ -n "$SHOW_GIT_BRANCH" ]]       || SHOW_GIT_BRANCH=false
[[ -n "$SHOW_GIT_SUPER_PROMPT" ]] || SHOW_GIT_SUPER_PROMPT=true

[[ -n "$SHOW_RETURN_CODE" ]]      || SHOW_RETURN_CODE=true
[[ -n "$DIRECTORY_DEPTH" ]]       || DIRECTORY_DEPTH=4

# select a prompt symbol for this terminal randomly
# (Go ahead add more symbols to this list)
SYMBOL_LIST=(ϗ δ ζ ξ χ λ ϟ ϑ Σ λ Ɲ Ħ ƍ Ξ Θ Ϡ Ϟ)
SYMBOL_LIST_LENGTH=${#SYMBOL_LIST[@]}
# The random symbol that will be displayed
THE_CHOSSEN_SYMBOL=${SYMBOL_LIST[$((${RANDOM} % SYMBOL_LIST_LENGTH))]}

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


# This function displays the operating system logo
show_os_logo() {
    # append the seperator symbol only if it's not the first emenent
    if [ $FIRST = false ]
    then
        PROMPT="${PROMPT}%K{${OS_LOGO_BG}}${SEPERATOR}"
    fi

    # Use the predefined logo and it's color and append it to the prompt
    PROMPT="${PROMPT}%F{${OS_LOGO_FG}}%K{${OS_LOGO_BG}}${PADDING}${LOGO}"
    # defining what cshould be the color of the foreground of the seperator
    # i.e. same as the background color of the logo
    PROMPT="${PROMPT} %F{${OS_LOGO_BG}}"
    FIRST=false
}

# This function displays the username
show_username() {
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
}

# This function displays the hostname of the machine
show_hostname() {
    # hostname
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
}


# datetime
show_date_time() {
    if [ $FIRST = false ]
    then
        PROMPT="${PROMPT}%K{${TIME_BG}}${SEPERATOR}"
    fi

    PROMPT="${PROMPT}%F{${TIME_FG}}%K{${TIME_BG}}${PADDING}${ZSH_TIME}"
    PROMPT="${PROMPT} %F{${TIME_BG}}"
    FIRST=false
}

show_pwd() {
    # a seperator
    if [ $FIRST = false ]
    then
        PROMPT="${PROMPT}%K{${DIRECOTORY_BG}}${SEPERATOR}"
    fi

    # current directory
    DIRECOTORY_DEPTH="%${DIRECTORY_DEPTH}~"
    PROMPT="${PROMPT}%F{${DIRECOTORY_FG}}%K{${DIRECOTORY_BG}} ${DIRECOTORY_DEPTH}"
    PROMPT="${PROMPT} %F{${DIRECOTORY_BG}}"
    FIRST=false
}

prompt_git() {
    local s='';
    local branchName=${ZSH_THEME_GIT_PROMPT_PREFIX};

    # Check if the current directory is in a Git repository.
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") = '0' ]; then

        # check if the current directory is in .git before running git checks
        if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" = 'false' ]; then

            # Ensure the index is up to date.
            git update-index --really-refresh -q &>/dev/null;

            # Check for uncommitted changes in the index.
            if ! $(git diff --quiet --ignore-submodules --cached); then
                s+=${ZSH_THEME_GIT_PROMPT_DIRTY};
            fi;

            # Check for unstaged changes.
            if ! $(git diff-files --quiet --ignore-submodules --); then
                s+=${ZSH_THEME_GIT_PROMPT_MODIFIED};
            fi;

            # Check for untracked files.
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                s+=${ZSH_THEME_GIT_PROMPT_ADDED};
            fi;

            # Check for stashed files.
            if $(git rev-parse --verify refs/stash &>/dev/null); then
                s+='$';
            fi;

        fi;

        # Get the short symbolic ref.
        # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
        # Otherwise, just give up.
        branchName+="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
                        git rev-parse --short HEAD 2> /dev/null || \
                        echo '(unknown)')";

        [ -n "${s}" ] && s=" ${s}";

        echo -e "${1}${branchName}${s}";
    else
        return;
    fi;
}


show_git() {
    # get git branch function
    git_branch() {
        git rev-parse --git-dir > /dev/null 2>&1
        if [ "$?" = "0" ]; then
            BRANCH=$(git branch | grep '*' | cut -d' ' -f2-)
            echo ${ZSH_THEME_GIT_PROMPT_PREFIX}${BRANCH}
        fi
    }
    # a seperator
    if [ $FIRST = false ]
    then
        PROMPT="${PROMPT}%K{${GIT_PROMPT_BG}}${SEPERATOR}"
    fi

    # GIT PROMPT DISPLAY
    if [ $SHOW_GIT_BRANCH ] || [ $SHOW_GIT_STATUS ] || [ $SHOW_GIT_SUPER_PROMPT ]
    then
        PROMPT="${PROMPT}%F{${GIT_PROMPT_FG}}"
    fi

    # show git status
    if [ $SHOW_GIT_BRANCH = true ]; then
        PROMPT="${PROMPT}"'$(git_branch)'
    elif [ $SHOW_GIT_STATUS = true ]; then
        PROMPT="${PROMPT}"'$(prompt_git)'
    elif [ $SHOW_GIT_SUPER_PROMPT = true ]; then
        PROMPT="${PROMPT}"'$(git_super_status)'
    fi

    if [ $SHOW_GIT_BRANCH ] || [ $SHOW_GIT_STATUS ] || [ $SHOW_GIT_SUPER_PROMPT ]
    then
        PROMPT="${PROMPT} ${RESET_COLOR}%F{${GIT_PROMPT_BG}}"
    fi
}

handle_single_line_or_double_line() {
    # single line or double lines
    if [ $SINGLE_LINE = false ]; then
        PROMPT="${PROMPT}%k${SEPERATOR}
${RESET}%F{${RANDOM_SYMBOL_FG}}%K{${RANDOM_SYMBOL_BG}} ${THE_CHOSSEN_SYMBOL} "
        PROMPT="${PROMPT}%k%F{${RANDOM_SYMBOL_BG}}${ARROW_SYMBOL}"
    else
        PROMPT="${PROMPT} %k${SEPERATOR}"
    fi
}

reset() {
    # reset
    PROMPT="$PROMPT ${RESET} "

    if [ $SHOW_RETURN_CODE = true ]; then
            RPROMPT="${RETURN_CODE}"
    fi
}

###########################################################
# Change the order of the functions to get desired result #
###########################################################

show_os_logo
show_username
show_hostname
# show_date_time
show_pwd

# Don't touch these for the time being

show_git
handle_single_line_or_double_line
reset
