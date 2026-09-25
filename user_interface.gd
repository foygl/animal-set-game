extends Control

var hints_remaining: int

var shuffling_label_fadeout = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shuffling_label_fadeout && $ShufflingEventTimer.time_left <= $ShufflingEventTimer.wait_time - 0.5:
		$ShufflingLabel.set_modulate(
			lerp($ShufflingLabel.get_modulate(), Color(1,1,1,0), 0.01)
		)

func new_game() -> void:
	update_hint_button(3)
	$GameOverLabel.visible = false
	$ShufflingLabel.visible = false
	$Cards.new_game()

func update_hint_button(count: int) -> void:
	if count <= 0:
		count = 0
		$HintButton.disabled = true
	else:
		$HintButton.disabled = false
	
	hints_remaining = count
	$HintButton.text = "Hint? %d" % count

func _on_hint_button_pressed() -> void:
	if hints_remaining > 0:
		$Cards.show_hint()
	update_hint_button(hints_remaining - 1)

func update_cards_remaining(count: int) -> void:
	$CardsRemainingLabel.text = "Cards Remaining: %d" % count

func display_shuffling_label() -> void:
	$ShufflingLabel.visible = true
	shuffling_label_fadeout = true
	$ShufflingEventTimer.start()

func _on_shuffling_event_timer_timeout() -> void:
	$ShufflingLabel.visible = false
	$ShufflingLabel.set_modulate(Color(1, 1, 1, 1))
	shuffling_label_fadeout = false

func game_over() -> void:
	$GameOverLabel.visible = true

func exit_game() -> void:
	get_tree().quit()
