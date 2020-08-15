extends Area

signal button_clicked
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var LabelText = "Label"
onready var caption_label = get_node("Display")

# Called when the node enters the scene tree for the first time.
func _ready():
	caption_label.set_text(LabelText)

func set_label(text):
	caption_label.set_text(text)

func _on_3DButton_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == 1:
			emit_signal("button_clicked")
		if event.is_action_released("left_click"):
			print_debug("Losg'losse")
