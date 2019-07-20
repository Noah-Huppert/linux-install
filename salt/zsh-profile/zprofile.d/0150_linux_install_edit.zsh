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
    prog_dir=$(realpath $(dirname "$0"))
    
    action="$1"
    shift
    if [ -z "$action" ]; then
	return $(unit-die "ACTION argument required")
    fi

    case "$action" in
	cd)
	    cd "$prog_dir"

	    if [[ "$#" != "0" ]]; then
		cd "$@"
	    fi
	    ;;
	edit)
	    path="$1"
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
