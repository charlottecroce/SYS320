#!/bin/bash

# list all ips in given network prefix, /24 only


# usage: bash IPList.bash 10.0.17
[ $# -lt 1 ] && echo "Usage: $0 <Prefix>" && exit 1

#prefix is the first input taken
prefix=$1

[ ${#prefix} -lt 5 ] && \
printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
exit 1

for i in {1..254}
do
    ping -c 1 $prefix.$i | grep "64 bytes from *" | \
    grep -o $prefix.$i
done
