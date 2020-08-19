extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Forcebar_bar = get_node("ForceBar/TextureProgress")
onready var lbl_type = get_node("VBoxContainer/lbl_type")
onready var lbl_mass = get_node("VBoxContainer/lbl_mass")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
func hide_force_bar():
	$ForceBar.visible = false
	
func set_force(current:float, maximum:float):
	if current == 0:
		Forcebar_bar.visible == false
	else:
		Forcebar_bar.visible == true
	Forcebar_bar.value = current/maximum *100
func set_type(text):
	lbl_type.text = text
	
func set_hint(hint):
	$VBoxContainer/lbl_hint.text = hint
	
func set_desc(desc):
	lbl_mass.text = desc
	
