extends Node

var cards: Array[Dictionary]

var current_cards: Array[TextureButton]

var current_card_permutations: Array[Array] = []

var selected_cards: Array[TextureButton] = []

signal game_over

signal shuffling

signal cards_remaining(count: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_game():
	cards = generate_cards()

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

	# This is every combination of three cards so that we can check if there is a valid solution.
	# We can just build this once
	current_card_permutations.clear()
	for i in range(10):
		for j in range(i + 1, 11):
			for k in range(j + 1, 12):
				current_card_permutations.append(
					[current_cards[i], current_cards[j], current_cards[k]]
				)

	selected_cards.clear()

	deal_cards()

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
	return cards

func deal_cards():
	cards.shuffle()
	var update_finished_signals = []
	for card in current_cards:
		if !cards.is_empty():
			card.update_card(cards.pop_back())
			update_finished_signals.append(card.update_finished)
		else:
			card.update_card({})
	for update_finished in update_finished_signals:
		await update_finished
	ensure_solvable()
	count_cards()

func count_cards():
	var card_count = cards.size()
	for card in current_cards:
		if !card.get_card().is_empty(): card_count += 1
	cards_remaining.emit(card_count)
	print_debug("%d cards remaining" % card_count)

func ensure_solvable():
	if !is_solveable():
		propagate_call("set_disabled", [true])
		if cards.is_empty():
			print_debug("Game over")
			game_over.emit()
		else:
			for card in current_cards:
				if !card.get_card().is_empty():
					cards.append(card.get_card())
			shuffling.emit()
			deal_cards()

func is_solveable() -> bool:
	var solution = get_first_solution()
	if solution.is_empty():
		print_debug("Solvable: false")
		return false
	else:
		print_debug("Solvable: true (%s, %s, %s)" % solution)
		return true

func get_first_solution() -> Array[TextureButton]:
	# Check every permutation of three cards to see if any are a solution
	for current_card_permutation in current_card_permutations:
		if check_cards(
			current_card_permutation[0].get_card(),
			current_card_permutation[1].get_card(),
			current_card_permutation[2].get_card()
		   ):
			return current_card_permutation
	return []

func check_cards(card1: Dictionary, card2: Dictionary, card3: Dictionary) -> bool:
	if card1.is_empty() || card2.is_empty() || card3.is_empty():
		return false
	
	var distinct_animals = {
		card1.animal: null,
		card2.animal: null,
		card3.animal: null,
	}.size()
	var distinct_patterns = {
		card1.pattern: null,
		card2.pattern: null,
		card3.pattern: null,
	}.size()
	var distinct_colours = {
		card1.colour: null,
		card2.colour: null,
		card3.colour: null,
	}.size()
	var distinct_numbers = {
		card1.number: null,
		card2.number: null,
		card3.number: null,
	}.size()
	
	# For each feature, either they should all match, or should all differ
	return distinct_animals != 2 \
		&& distinct_patterns != 2 \
		&& distinct_colours != 2 \
		&& distinct_numbers != 2

func check_selected_cards() -> bool:
	return check_cards(
		selected_cards[0].get_card(),
		selected_cards[1].get_card(),
		selected_cards[2].get_card()
	)

func _on_card_toggled(toggled_on: bool, source: BaseButton) -> void:
	if toggled_on:
		if selected_cards.size() >= 3:
			source.button_pressed = false
		else:
			selected_cards.append(source)
	else:
		selected_cards.erase(source)
	
	if selected_cards.size() == 3:
		if check_selected_cards():
			for card in selected_cards:
				if !cards.is_empty():
					card.update_card(cards.pop_back())
				else:
					card.update_card({})
			selected_cards.clear()
			ensure_solvable()
			count_cards()

func show_hint() -> void:
	for card in current_cards:
		card.deselect()
	selected_cards.clear()
	for card in get_first_solution():
		card.show_hint()
