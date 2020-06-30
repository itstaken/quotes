#!/bin/bash
##
# Pull a quote via quotes.txt, and put that onto a background.
readarray -t QUOTE < <(bash ./quotes.sh)

QUOTE_FONT='DejaVu-Sans-Condensed-Oblique'
AUTHOR_FONT='DejaVu-Sans-Condensed-Bold'
TEXT_COLOR='#ffb52a'

##
# Rendered quoted text goes here
QUOTE_FILE=$(mktemp --suffix .png)
##
# Author attribution goes here
AUTH_FILE=$(mktemp --suffix .png)
##
# The quote and attribution together go here
COMBINED=$(mktemp --suffix .png)
##
# A rounded rectangle to hold the combined text
BACKGROUND=$(mktemp --suffix .png)
##
# An image that is complete, except for the missing caption
TEXTLESS=$(mktemp --suffix .png)
FINAL=$(mktemp --suffix .png)

DIM=$(file "${1}" | grep -o '[0-9]\+\W*x\W*[0-9]\+' | tail -n 1)
DIM_X=$(echo $DIM | awk '{print $1}')
DIM_X=$((DIM_X-15))

##
# Rnder quote...
convert -background none -fill "${TEXT_COLOR}" -font "${QUOTE_FONT}" -pointsize 48 -size ${DIM_X}x caption:"${QUOTE[0]}" -trim +repage -bordercolor None -border 1x1 "${QUOTE_FILE}"
##
# Render the author attribution
convert -background none -fill "${TEXT_COLOR}" -font "${QUOTE_FONT}" -pointsize 20 label:"${QUOTE[1]}" -trim +repage -bordercolor None -border 1x1 "${AUTH_FILE}"
##
# Stick the quote to the author attribution
convert -background none "$QUOTE_FILE" -gravity SouthEast "$AUTH_FILE" -append "$COMBINED"

DIM=$(file "${COMBINED}" | grep -o '[0-9]\+\W*x\W*[0-9]\+' | tail -n 1)
DIM_X=$(echo $DIM | awk '{print $1}')
DIM_Y=$(echo $DIM | awk '{print $3}')
DIM_X=$((DIM_X+15))
DIM_Y=$((DIM_Y+15))

##
# Created a rounded rectnangle to use as the caption background
convert -size ${DIM_X}x${DIM_Y} xc:none -background none -fill black \
    -draw "roundrectangle 5,5 ${DIM_X},${DIM_Y} 15,15" "${BACKGROUND}"
##
# Now blend that background onto the wallpaper provided to create a space for the caption to go.
composite -blend 60 "${BACKGROUND}" -gravity South "${1}" "${TEXTLESS}"

##
# Now blend the text into TEXTLESS space and produce the final output image.
composite -blend 60 "${COMBINED}" -gravity South "${TEXTLESS}" "${FINAL}"

##
# Now delete the millions of temporary files just created
rm ${QUOTE_FILE} ${AUTH_FILE} ${COMBINED} ${BACKGROUND} ${TEXTLESS}

##
# Finally, display the path to the file (that wasn't deleted) containing the caption and background
echo "${FINAL}"
