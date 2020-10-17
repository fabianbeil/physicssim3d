extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var digit_scene = preload("res://Scenes/Objects/TextureDisplay/Digit.tscn")
onready var comma_scene = preload("res://Scenes/Objects/TextureDisplay/Comma.tscn")
var Scenes = []

func set_text(text: String):
	var position_in_text = 0
	var new_char: Spatial
	for zeichen in text:
		if zeichen in ["0","1","2","3","4","5","6","7","8","9"]:
			new_char = digit_scene.instance()
			add_child(new_char)
			new_char.translation = Vector3(position_in_text,0,0)
			new_char.set_value(int(zeichen))
			position_in_text += .55
		if zeichen == ".":
			new_char = comma_scene.instance()
			add_child(new_char)
			new_char.translation = Vector3(position_in_text,0,0)
			position_in_text += .25

func _ready():
	set_text("12.345")
