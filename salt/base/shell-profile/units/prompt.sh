# Customizes the Zsh prompt

# Colors
# From: https://stackoverflow.com/a/20983251
color_vars() {
    if [ -z "$SHELL_UNIT_PROMPT_NO_COLOR" ]; then
	COLOR_RESET="\001$(tput sgr0)\002"

	COLOR_BG_RED="\001$(tput setab 1)\002"
	COLOR_BG_DEFAULT="\001$(tput setab 245)\002"

	COLOR_FG_WHITE="\001$(tput setaf 255)\002"
	COLOR_FG_GREEN="\001$(tput setaf 2)\002"
	COLOR_FG_MAGENTA="\001$(tput setaf 5)\002"
	COLOR_FG_RED="\001$(tput setaf 1)\002"
    else
	COLOR_RESET=""

	COLOR_BG_RED=""
	COLOR_BG_DEFAULT=""

	COLOR_FG_WHITE=""
	COLOR_FG_GREEN=""
	COLOR_FG_MAGENTA=""
	COLOR_FG_RED=""
    fi
}

color_vars

shell-no-color() {
    echo "\001$(tput sgr0)\002" # reset
    
    if [ -z "$SHELL_UNIT_PROMPT_NO_COLOR" ]; then
	SHELL_UNIT_PROMPT_NO_COLOR=true
    else
	SHELL_UNIT_PROMPT_NO_COLOR=""
    fi

    echo "SHELL_UNIT_PROMPT_NO_COLOR=$SHELL_UNIT_PROMPT_NO_COLOR"

    color_vars
    build_prompt
}

# Prints a check or an x depending on the exit status of the last command.
# Takes an exist status as an argument and outputs a prompt for that status. It is
# required as an argument bc the exit status for the last command the user runs
# will be overriden by the exit status's of other internal prompt building functions
# like this one.
exit_status_prompt() { # ( Exit status )
    if [[ "$1" != "0" ]]; then
	   echo "${COLOR_BG_RED}$1${COLOR_BG_DEFAULT} "
    fi
}

# Prints git:BRANCH to prompt if in git directory.
# If SHELL_PROFILE_PROMPT_SUPERSHORT is set nothing
# will show.
git_prompt() {
	label_txt="git:"
	if [ -z "$SHELL_PROFILE_PROMPT_SUPERSHORT" ]; then
	    # Get current branch
	    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

	    if [[ "$?" != "0" ]]; then # Probably not in Git repository
		   return 0
	    fi

	    echo "${COLOR_FG_GREEN}git:${COLOR_FG_MAGENTA}$branch"
	fi
}

## Escapes paths for use in sed
escape_path() { # ( PATH )
    echo "$1" | sed 's/\//\\\//g'
}

## Replaces pieces of path with shortcut name
shortcut_path() { # STDIN, ( FIND, REPLACE )
    sed_str="s/$(escape_path $1)/$(escape_path $2)/g"
    cat - | sed "$sed_str"
}

## Shows PWD with shortcuts to make shorter.
# Ensures the prompt is never longer than MAX_PROMPT_PWD_LEN. If the PWD does have
# to be trimmed then the first 2 root directories are shown and then the 
# current directory. If SHELL_PROFILE_PROMPT_SUPERSHORT is set only the exit status,
# current directory, and git branch are shown.
pwd_prompt() {
    d=""
    
    # Shorten if in supershort mode
    if [ -n "$SHELL_PROFILE_PROMPT_SUPERSHORT" ]; then
	   d="${PWD##*/}"
    else # Normal prompt mode
	   # Apply nicknames to the path
	   d="$PWD"
	   d=$(echo "$d" | shortcut_path "/etc/linux-install" "[li]")
	   d=$(echo "$d" | shortcut_path "$HOME/documents/work/red-hat" "~/[red-hat]")
	   d=$(echo "$d" | shortcut_path "$HOME/documents/work/cambrio" "~/[cambrio]")
	   d=$(echo "$d" | shortcut_path "$HOME/documents/school" "~/[school]")
	   d=$(echo "$d" | shortcut_path "$HOME/documents" "~/[docs]")
	   d=$(echo "$d" | shortcut_path "$GOPATH/src/github.com" "~/[go]/[srcgh]")
	   d=$(echo "$d" | shortcut_path "$GOPATH" "~/[go]")
	   d=$(echo "$d" | shortcut_path "$HOME" "~")
    fi
    
    echo "${COLOR_FG_RED}$d"
}

user_symbol() {
    if [ "$UID" -eq 0 ]; then
	   echo "#"
    else
	   echo "%"
    fi
}

# Sets prompt variable
build_prompt() {
    # Capture the last cmd's exit status before we run internal prompt building
    # functions. This will be passed to exit_status_prompt()
    last_cmd_exit_status="$?"

    newline_end=""
    if [ -n "$SHELL_PROFILE_PROMPT_SUPERSHORT" ]; then
	   newline_end="\n"
    fi
    
    # EXIT_STATUS HOSTNAME PATH git:BRANCH %#
    export PS1="$(exit_status_prompt $last_cmd_exit_status)$(pwd_prompt) $(git_prompt) ${COLOR_FG_WHITE}${newline_end}$(user_symbol) "
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

# Toggle SHELL_PROFILE_PROMPT_SUPERSHORT and rebuild the
# prompt. So that the prompt is way shorter.
supershort() {
    if [ -z "$SHELL_PROFILE_PROMPT_SUPERSHORT" ]; then
	   SHELL_PROFILE_PROMPT_SUPERSHORT=true
    else
	   SHELL_PROFILE_PROMPT_SUPERSHORT=""
    fi

    build_prompt
    echo "SHELL_PROFILE_PROMPT_SUPERSHORT=${SHELL_PROFILE_PROMPT_SUPERSHORT}"
}
