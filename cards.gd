extends Node

var cards: Array[Dictionary] = generate_cards()

var current_cards: Array[TextureButton]

var selected_cards: Array[TextureButton] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_cards = [
		$Card01,
		$Card02,
		$Card03,
		$Card04,
		$Card05,
		$Card06,
		$Card07,
		$Card08,
		$Card09,
		$Card10,
		$Card11,
		$Card12
	]

	for card in current_cards:
		card.update_card(cards.pop_back())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_cards():
	cards = []
	for animal in ['bird', 'bunny', 'fish']:
		for pattern in ['hex', 'waves', 'filled']:
			for colour in ['red', 'green', 'blue']:
				for number in ['one', 'two', 'three']:
					cards.append({
						'animal': animal,
						'pattern': pattern,
						'colour': colour,
						'number': number
					})
	cards.shuffle()
	return cards

func is_solveable() -> bool:
	return false

func _on_card_toggled(toggled_on: bool, source: BaseButton) -> void:
	if toggled_on:
		if selected_cards.size() >= 3:
			source.button_pressed = false
		else:
			selected_cards.append(source)
	else:
		selected_cards.erase(source)
	
	if selected_cards.size() == 3:
		if check_cards():
			for card in selected_cards:
				card.update_card(cards.pop_back())
			selected_cards.clear()

func check_cards() -> bool:
	var distinct_animals = {
		selected_cards[0].get_card().animal: null,
		selected_cards[1].get_card().animal: null,
		selected_cards[2].get_card().animal: null,
	}.size()
	var distinct_patterns = {
		selected_cards[0].get_card().pattern: null,
		selected_cards[1].get_card().pattern: null,
		selected_cards[2].get_card().pattern: null,
	}.size()
	var distinct_colours = {
		selected_cards[0].get_card().colour: null,
		selected_cards[1].get_card().colour: null,
		selected_cards[2].get_card().colour: null,
	}.size()
	var distinct_numbers = {
		selected_cards[0].get_card().number: null,
		selected_cards[1].get_card().number: null,
		selected_cards[2].get_card().number: null,
	}.size()
	
	# For each feature, either they should all match, or should all differ
	return distinct_animals != 2 \
		&& distinct_patterns != 2 \
		&& distinct_colours != 2 \
		&& distinct_numbers != 2
