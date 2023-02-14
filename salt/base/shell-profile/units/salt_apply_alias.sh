# Create alias for salt-apply command

if (( $UID != 0 )); then
    alias sa='sudo salt-apply'
else
    alias sa='salt-apply'
fi
