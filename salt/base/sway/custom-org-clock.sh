#!/usr/bin/env bash
# Checks if there is a current org-mode clock running.
# If so prints its details. Otherwise outputs nothing and
# exits silently. The output is JSON formatted
# for waybar.

prog_dir=$(dirname $(realpath "$0"))
err_file="$prog_dir/custom-org-clock.err"
echo "" > "$err_file"

resp_text=""
resp_alt=clock
resp_tooltip=""

update_org_clock() {
        clock_str=$(emacsclient --eval "(if org-clock-current-task (substring-no-properties (org-clock-get-clock-string)))" 2> "$err_file")
    if [[ "$?" != "0" ]]; then
	   resp_text="org clock error"
	   resp_tooltip=$(cat "$err_file")
	   return
    fi

    clock_str=$(echo "$clock_str" | sed 's/"//g')
    
    if [[ "$clock_str" == "nil" ]]; then
	   # No clock running
	   resp_alt=nil
	   return
    fi
    
    # Clock running
    resp_text="$clock_str"
}

update_org_clock
echo "{ \"text\": \"$resp_text\", \"alt\": \"$resp_alt\", \"tooltip\": \"$resp_tooltip\" }"
