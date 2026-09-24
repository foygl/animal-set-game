extends TextureButton

var animal
var pattern
var colour
var number

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_card(card: Dictionary):
	disabled = true
	visible = false
	$Selected.visible = false
	
	if card == null:
		animal = null
		pattern = null
		colour = null
		number = null
	else:
		animal = card.animal
		pattern = card.pattern
		colour = card.colour
		number = card.number
		
		var img = Image.new()
		img.load("res://assets/%s_%s_%s_%s.png" % [animal, pattern, colour, number])
		texture_normal = ImageTexture.create_from_image(img)
		
		$CardUpdateTimer.start()

func get_card() -> Dictionary:
	return {
		'animal': animal,
		'pattern': pattern,
		'colour': colour,
		'number': number
	}

func _on_toggled(toggled_on: bool) -> void:
	$Selected.visible = toggled_on


func _on_card_update_timer_timeout() -> void:
	disabled = false
	visible = true
	button_pressed = false
