#!/bin/bash

set -e

black_colour_code="#010000"
red_colour_code="#c14a54"
green_colour_code="#47924b"
blue_colour_code="#2b5fc4"

for animal in bird bunny fish
do
  for pattern in hex maze waves filled
  do
    for colour in red green blue
    do
      colour_code="${colour}"_colour_code
      for number in one two three
      do
	if [ ! -e ${animal}_${pattern}_${colour}_${number}.png ]
        then
	  cp card_templates/${animal}_${pattern}_black_${number}.svg ${animal}_${pattern}_${colour}_${number}.svg
	  sed -i "" "s/${animal}_${pattern}_black_${number}.svg/${animal}_${pattern}_${colour}_${number}.svg/; s/${black_colour_code}/${!colour_code}/g" ${animal}_${pattern}_${colour}_${number}.svg
	
          convert ${animal}_${pattern}_${colour}_${number}.svg -matte card_templates/round_corner_mask.png -compose DstIn -composite ${animal}_${pattern}_${colour}_${number}.png

	  rm ${animal}_${pattern}_${colour}_${number}.svg
	fi
      done
    done
  done
done
