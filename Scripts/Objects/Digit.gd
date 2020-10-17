extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Meshes = []
var current_number = 0
var test = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for number in range(10):
		Meshes.append(get_node("MeshInstance" + str(number)))

func set_value(value: int):
	Meshes[current_number].visible = false
	Meshes[value].visible = true
	current_number = value
