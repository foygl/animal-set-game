extends TextureButton

var card: Dictionary = {}

signal update_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_card(c: Dictionary):
	disabled = true
	visible = false
	$Selected.visible = false
	
	if c == null || c.is_empty():
		card = {}
		update_finished.emit()
	else:
		card = c
		
		var img = Image.new()
		img.load("res://assets/%s_%s_%s_%s.png" % [c.animal, c.pattern, c.colour, c.number])
		texture_normal = ImageTexture.create_from_image(img)
		
		$CardUpdateTimer.start()

func get_card() -> Dictionary:
	return card

func _on_toggled(toggled_on: bool) -> void:
	$Selected.visible = toggled_on


func _on_card_update_timer_timeout() -> void:
	disabled = false
	visible = true
	button_pressed = false
	update_finished.emit()
