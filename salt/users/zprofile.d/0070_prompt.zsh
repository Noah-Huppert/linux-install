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

# Sets prompt variable
function build_prompt() {
	# HOSTNAME PATH git:BRANCH %#
	export PROMPT="%{$fg[blue]%}%m%{$reset_color%} %{$fg[red]%}%/%{$reset_color%}$(git_prompt) %# "
}

build_prompt
add-zsh-hook chpwd build_prompt
