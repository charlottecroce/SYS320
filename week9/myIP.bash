#!/bin/bash

# display ONLY IP address
# output ip addr command
# grep for enabled interfaces
# grep to narrow in on IP
# use tr to delete extra letters and spaces from output
ip address | grep 'state UP' -A 3 | grep -o 'inet.*brd' | tr -d 'a-z '



