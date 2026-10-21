# Animal Set

![Animal set splash screen](/boot-splash.png)

The game of [Set](https://en.wikipedia.org/wiki/Set_(card_game)), but with animal pictures!

Written very quickly in Godot. No bells or whistles.

## Play!

[Play the game!](https://foygl.github.io/animal-set-game/exported/web/animal_set.html)

You can also find built binaries for multiple platforms in the latest release

## Instructions

The deck consists of 81 cards, each with 4 attributes:
- Colour (red, green or blue)
- Animal (rabbit, fish or bird)
- Number (1, 2 or 3)
- Pattern (spotty, hatched, solid fill)

You must pick 3 cards such that for each of the 4 attributes:
- The three cards are all the same for that attribute (e.g. all red for colour)
- The three cards are all different for that attribute (e.g. one is red, one is green and one is blue for colour)

Here are some examples of valid sets:

- Same colour, same animal, different number, same pattern
<p float="middle">
  <img src="/assets/bird_filled_blue_one.png" width="100" style="border:1px solid black;" />
  <img src="/assets/bird_filled_blue_two.png" width="100" style="border:1px solid black;" />
  <img src="/assets/bird_filled_blue_three.png" width="100" style="border:1px solid black;" />
</p>

- Different colour, different animal, different number, different pattern
<p float="middle">
  <img src="/assets/bird_filled_blue_one.png" width="100" style="border:1px solid black;" />
  <img src="/assets/bunny_hex_green_two.png" width="100" style="border:1px solid black;" />
  <img src="/assets/fish_waves_red_three.png" width="100" style="border:1px solid black;" />
</p>

- Different colour, different animal, same number, same pattern
<p float="middle">
  <img src="/assets/bird_waves_blue_one.png" width="100" style="border:1px solid black;" />
  <img src="/assets/bunny_waves_green_one.png" width="100" style="border:1px solid black;" />
  <img src="/assets/fish_waves_red_one.png" width="100" style="border:1px solid black;" />
</p>
