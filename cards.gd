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
		print_debug(card)
		card.update_card(cards.pop_back())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_cards():
	cards = []
	for animal in ['bird', 'bunny', 'fish']:
		for pattern in ['hex', 'maze', 'waves']:
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
