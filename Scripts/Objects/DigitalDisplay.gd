extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var label = get_node("Viewport/Label")
export var start_text = "Label"

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = start_text

func set_text(text):
	label.text = text
	
