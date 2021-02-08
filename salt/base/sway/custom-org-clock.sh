#!/usr/bin/env bash
# Checks if there is a current org-mode clock running.
# If so prints its details. Otherwise outputs nothing and
# exits silently. The output is JSON formatted
# for waybar.

resp_text=""
resp_alt=clock
resp_tooltip=""

update_org_clock() {
    clock_str=$(emacsclient --eval "(if org-clock-current-task (substring-no-properties (org-clock-get-clock-string)))" | sed 's/"//g')
    
    if [ "$?" -ne "0" ]; then
	   resp_text="org clock error"
	   resp_tooltip="$clock_str"
	   return
    fi

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
