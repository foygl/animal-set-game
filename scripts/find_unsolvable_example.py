#!/usr/bin/env python3

import numpy as np
import itertools as it

CARDS = np.array([
    [animal,pattern,colour,number]
    for animal in range(3)
    for pattern in range(3)
    for colour in range(3)
    for number in range(3)
])

SAMPLE_SIZE = 20

ANIMAL = ['bird', 'bunny', 'fish']
PATTERN = ['hex', 'waves', 'filled']
COLOUR = ['red', 'green', 'blue']
NUMBER = ['one', 'two', 'three']

while True:
    sample_of_N = CARDS[np.random.choice(81,SAMPLE_SIZE,replace=False)]
    no_set_for_sample = all(
        any(sum(sample_of_3)%3) # = no set in this sample of 3
        for sample_of_3 in it.combinations(sample_of_N, 3) 
    )
    if no_set_for_sample > 0:
        cards = []
        for card in sample_of_N:
            cards.append({
                'animal': ANIMAL[card[0]],
                'pattern': PATTERN[card[1]],
                'colour': COLOUR[card[2]],
                'number': NUMBER[card[3]]
            })
        print(cards)
        quit()
