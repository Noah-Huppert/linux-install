# Shortcut to edit this repository
#?
# li - Linux install shortcut
#
# USAGE
#
#    li ACTION EXTRA
#
# ARGUMENTS
#
#    ACTION    Action to perform, one of "cd" or "edit"
#    EXTRA     Extra data used action, optional if ACTION == "cd", required if ACTION == "edit"
#
#?
function li() {
    prog_dir={{ pillar.linux_install_repo.directory }}

    action="$1"
    shift
    if [ -z "$action" ]; then
	return $(unit-die "ACTION argument required")
    fi

    case "$action" in
	cd)
	    cd "$prog_dir"

	    if [[ "$#" != "0" ]]; then
		cd "$prog_dir/$@"
	    fi
	    ;;
	edit)
	    path="$@"
	    shift
	    if [ -z "$path" ]; then
		return $(unit-die "PATH argument required")
	    fi
	    
	    "$EDITOR" "$prog_dir/$path"
	    ;;
	*)
	    return $(unit-die "Unknown action \"$action\"")
	    ;;
    esac
}
