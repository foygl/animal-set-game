#!/bin/bash

for animal in bird bunny fish
do
  for pattern in hex maze waves
  do
    for colour in red green blue
    do
      for number in one two three
      do
	if [ ! -e ${animal}_${pattern}_${colour}_${number}.png ]
        then
          convert ${animal}_${pattern}_${colour}_${number}.svg -matte round_corner_mask.png -compose DstIn -composite ${animal}_${pattern}_${colour}_${number}.png
	fi
      done
    done
  done
done
