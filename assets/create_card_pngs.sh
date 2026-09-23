#!/bin/bash

for animal in bird bunny fish
do
  for pattern in hex maze waves
  do
    for colour in red green blue
    do
      convert ${animal}_${pattern}_${colour}.svg -matte round_corner_mask.png -compose DstIn -composite ${animal}_${pattern}_${colour}.png
    done
  done
done
