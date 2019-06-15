# Customizes the Zsh prompt

# Load colors module
autoload -U colors && colors
autoload -U add-zsh-hook

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
    d=$(echo "$d" | shortcut_path "$HOME/documents/school" "~/[school]")
    d=$(echo "$d" | shortcut_path "$HOME/documents" "~/[docs]")
    d=$(echo "$d" | shortcut_path "$HOME" "~")

    echo "$d"
}

# Sets prompt variable
function build_prompt() {
	# HOSTNAME PATH git:BRANCH %#
	export PROMPT="%{$fg[red]%}$(pwd_prompt)%{$reset_color%}$(git_prompt) %# "
}

build_prompt
add-zsh-hook precmd build_prompt
