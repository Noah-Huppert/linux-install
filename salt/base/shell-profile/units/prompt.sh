# Customizes the Zsh prompt

# Colors
# From: https://stackoverflow.com/a/20983251
# Colors are disabled rn bc they cause issues with emacs line wrapping
# COLOR_RESET=""

# COLOR_BG_RED=""

# COLOR_FG_GREEN=""
# COLOR_FG_MAGENTA=""
# COLOR_FG_RED=""

COLOR_RESET=$(tput sgr0)

COLOR_BG_RED=$(tput setab 1)

COLOR_FG_GREEN=$(tput setaf 2)
COLOR_FG_MAGENTA=$(tput setaf 5)
COLOR_FG_RED=$(tput setaf 1)

# Prints a check or an x depending on the exit status of the last command.
# Takes an exist status as an argument and outputs a prompt for that status. It is
# required as an argument bc the exit status for the last command the user runs
# will be overriden by the exit status's of other internal prompt building functions
# like this one.
function exit_status_prompt() { # ( Exit status )
    if [[ "$1" != "0" ]]; then
	   echo "${COLOR_BG_RED}$1${COLOR_RESET} "
    fi
}

# Prints git:BRANCH to prompt if in git directory
function git_prompt() {
	# Get current branch
	branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

	if [[ "$?" != "0" ]]; then # Probably not in Git repository
		return 0
	fi

	echo " ${COLOR_FG_GREEN}git${COLOR_RESET}:${COLOR_FG_MAGENTA}$branch${COLOR_RESET}"
}

## Escapes paths for use in sed
function escape_path() { # ( PATH )
    echo "$1" | sed 's/\//\\\//g'
}

## Replaces pieces of path with shortcut name
function shortcut_path() { # STDIN, ( FIND, REPLACE )
    sed_str="s/$(escape_path $1)/$(escape_path $2)/g"
    cat - | sed "$sed_str"
}

## Shows PWD with shortcuts to make shorter.
# Ensures the prompt is never longer than MAX_PROMPT_PWD_LEN. If the PWD does have
# to be trimmed then the first 2 root directories are shown and then the 
# current directory.
function pwd_prompt() {
    d="$PWD"
    d=$(echo "$d" | shortcut_path "/etc/linux-install" "[li]")
    d=$(echo "$d" | shortcut_path "$HOME/documents/work/red-hat" "~/[red-hat]")
    d=$(echo "$d" | shortcut_path "$HOME/documents/work/cambrio" "~/[cambrio]")
    d=$(echo "$d" | shortcut_path "$HOME/documents/school" "~/[school]")
    d=$(echo "$d" | shortcut_path "$HOME/documents" "~/[docs]")
    d=$(echo "$d" | shortcut_path "$GOPATH/src/github.com" "~/[go]/[srcgh]")
    d=$(echo "$d" | shortcut_path "$GOPATH" "~/[go]")
    d=$(echo "$d" | shortcut_path "$HOME" "~")

    echo "${COLOR_FG_RED}$d${COLOR_RESET}"
}

function user_symbol() {
    if [ "$UID" -eq 0 ]; then
	   echo "#"
    else
	   echo "%"
    fi
}

# Sets prompt variable
function build_prompt() {
    # Capture the last cmd's exit status before we run internal prompt building
    # functions. This will be passed to exit_status_prompt()
    last_cmd_exit_status="$?"
    
    # EXIT_STATUS HOSTNAME PATH git:BRANCH %#
    export PS1="$(exit_status_prompt $last_cmd_exit_status)$(pwd_prompt)$(git_prompt) $(user_symbol) "
}

source {{ pillar.bash.preexec.file }}
npreexec () {
    # Do nothing
    :;
}
precmd() {
    build_prompt
}
build_prompt
