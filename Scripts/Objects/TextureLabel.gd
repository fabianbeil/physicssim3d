extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var digit_scene = preload("res://Scenes/Objects/TextureDisplay/Digit.tscn")
onready var comma_scene = preload("res://Scenes/Objects/TextureDisplay/Comma.tscn")
onready var quantity_scene = preload("res://Scenes/Objects/TextureDisplay/Letter.tscn")
onready var minus_scene = preload("res://Scenes/Objects/TextureDisplay/Minus.tscn")
onready var colon_scene = preload("res://Scenes/Objects/TextureDisplay/Colon.tscn")


var Scenes = []

func set_text(text: String):
	for scene in Scenes:
		scene.queue_free()
	var position_in_text = 0
	var new_char: Spatial
	for zeichen in text:
		if zeichen in ["0","1","2","3","4","5","6","7","8","9"]:
			new_char = digit_scene.instance()
			add_child(new_char)
			new_char.translation = Vector3(position_in_text,0,0)
			new_char.set_value(int(zeichen))
			position_in_text += .6
		if zeichen == ".":
			new_char = comma_scene.instance()
			add_child(new_char)
			new_char.translation = Vector3(position_in_text,0,0)
			position_in_text += .25
		if zeichen == ":":
			new_char = colon_scene.instance()
			add_child(new_char)
			new_char.translation = Vector3(position_in_text,0,0)
			position_in_text += .25
		if zeichen in ["x","y","t","m","s"]:
			new_char = quantity_scene.instance()
			add_child(new_char)
			new_char.translation = Vector3(position_in_text,0,0)
			new_char.set_value(zeichen)
			position_in_text += .75
		if zeichen == "-":
			new_char = minus_scene.instance()
			add_child(new_char)
			new_char.translation = Vector3(position_in_text,0,0)
			position_in_text += .3
		if zeichen == " ":
			position_in_text += .45
	
func _ready():
	pass
