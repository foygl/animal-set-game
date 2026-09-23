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
	if card == null:
		animal = null
		pattern = null
		colour = null
		number = null
		
		visible = false
	else:
		animal = card.animal
		pattern = card.pattern
		colour = card.colour
		number = card.number
		
		visible = true
		
		var img = Image.new()
		img.load("res://assets/%s_%s_%s_%s.png" % [animal, pattern, colour, number])
		texture_normal = ImageTexture.create_from_image(img)

func get_card() -> Dictionary:
	return {
		'animal': animal,
		'pattern': pattern,
		'colour': colour,
		'number': number
	}

func _on_toggled(toggled_on: bool) -> void:
	$Selected.visible = toggled_on
