extends Node

var cards: Array[Dictionary] = generate_cards()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Card01.update_card(cards.pop_back())
	$Card02.update_card(cards.pop_back())
	$Card03.update_card(cards.pop_back())
	$Card04.update_card(cards.pop_back())
	$Card05.update_card(cards.pop_back())
	$Card06.update_card(cards.pop_back())
	$Card07.update_card(cards.pop_back())
	$Card08.update_card(cards.pop_back())
	$Card09.update_card(cards.pop_back())
	$Card10.update_card(cards.pop_back())
	$Card11.update_card(cards.pop_back())
	$Card12.update_card(cards.pop_back())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_cards():
	cards = []
	for animal in ['bird', 'bunny', 'fish']:
		for pattern in ['hex', 'maze', 'waves']:
			for colour in ['red', 'green', 'blue']:
				cards.append({
					'animal': animal,
					'pattern': pattern,
					'colour': colour,
					'resource': "res://assets/%s_%s_%s.png" % [animal, pattern, colour]
				})
	cards.shuffle()
	return cards
