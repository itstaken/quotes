#!/bin/bash

##
# Read in the quotes, put them in an array, and then pick one at random to output.

##
# Read logic
readarray -t LINES < quotes.txt
LENGTH=${#LINES[@]}
##
# Stop = number of quotes
STOP=$((LENGTH/3))

##
# Loop over all the entries and echo them.
dump_all() {
echo $STOP
for ((i=0;i<$STOP;i++)) ; do
    QUOTE=${LINES[$((i*3))]}
    ATTRIB=${LINES[$((i*3+1))]}
    echo $QUOTE
    echo $ATTRIB
done
}

just_one() {
    local i=$1
    QUOTE=${LINES[$((i*3))]}
    ATTRIB=${LINES[$((i*3+1))]}
    echo $QUOTE
    echo $ATTRIB
}

random_quote() {
    local i=$((RANDOM%STOP))
    just_one $i
}

random_quote
