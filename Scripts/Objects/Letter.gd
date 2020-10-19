extends Spatial


var Meshes = []
var current_char = "x"
var test = 0
var char_dict = {"x":0, "y":1, "t":2, "m":3,"s":4}
# Called when the node enters the scene tree for the first time.
func _ready():
	for number in range(5):
		Meshes.append(get_node("MeshInstance" + str(number)))

func set_value(value: String):
	Meshes[char_dict[current_char]].visible = false
	Meshes[char_dict[value]].visible = true
	current_char = value
