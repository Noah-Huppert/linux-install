# Customizes the Zsh prompt

# Load colors module
autoload -U colors && colors
autoload -U add-zsh-hook

# Prints a check or an x depending on the exit status of the last command.
# Takes an exist status as an argument and outputs a prompt for that status. It is
# required as an argument bc the exit status for the last command the user runs
# will be overriden by the exit status's of other internal prompt building functions
# like this one.
function exit_status_prompt() { # ( Exit status )
    if [ "$1" -ne "0" ]; then
	   echo "%{$bg[red]%}$1%{$reset_color%} "
    fi
}

# Prints git:BRANCH to prompt if in git directory
function git_prompt() {
	# Get current branch
	branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

	if [[ "$?" != "0" ]]; then # Probably not in Git repository
		return 0
	fi

	echo " %{$fg[green]%}git%{$reset_color%}:%{$fg[magenta]%}$branch%{$reset_color%}"
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

## Shows PWD with shortcuts to make shorter
function pwd_prompt() {
    d="$PWD"
    d=$(echo "$d" | shortcut_path "$HOME/documents/work/red-hat" "~/[red-hat]")
    d=$(echo "$d" | shortcut_path "$HOME/documents/work/cambrio" "~/[cambrio]")
    d=$(echo "$d" | shortcut_path "$HOME/documents/school" "~/[school]")
    d=$(echo "$d" | shortcut_path "$HOME/documents" "~/[docs]")
    d=$(echo "$d" | shortcut_path "$GOPATH/src/github.com" "~/[go]/[srcgh]")
    d=$(echo "$d" | shortcut_path "$GOPATH" "~/[go]")
    d=$(echo "$d" | shortcut_path "$HOME" "~")

    echo "%{$fg[red]%}$d%{$reset_color%}"
}

# Sets prompt variable
function build_prompt() {
    # Capture the last cmd's exit status before we run internal prompt building
    # functions. This will be passed to exit_status_prompt()
    last_cmd_exit_status="$?"
    
    # [EXIT_STATUS] HOSTNAME PATH git:BRANCH %#
    export PROMPT="$(pwd_prompt)$(git_prompt) %# "
    export RPROMPT="$(exit_status_prompt $last_cmd_exit_status)"
}

build_prompt
add-zsh-hook precmd build_prompt
