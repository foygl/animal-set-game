extends Control

var shuffling_label_fadeout = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameOverLabel.visible = false
	$ShufflingLabel.visible = false
	$Cards.new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shuffling_label_fadeout && $ShufflingEventTimer.time_left <= $ShufflingEventTimer.wait_time - 0.5:
		$ShufflingLabel.set_modulate(
			lerp($ShufflingLabel.get_modulate(), Color(1,1,1,0), 0.01)
		)

func update_cards_remaining(count: int) -> void:
	$CardsRemainingLabel.text = "Cards Remaining: %d" % count

func game_over() -> void:
	$GameOverLabel.visible = true

func display_shuffling_label() -> void:
	$ShufflingLabel.visible = true
	shuffling_label_fadeout = true
	$ShufflingEventTimer.start()

func _on_shuffling_event_timer_timeout() -> void:
	$ShufflingLabel.visible = false
	$ShufflingLabel.set_modulate(Color(1, 1, 1, 1))
	shuffling_label_fadeout = false

func new_game() -> void:
	$GameOverLabel.visible = false
	$ShufflingLabel.visible = false
	$Cards.new_game()
