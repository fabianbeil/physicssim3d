extends Particles


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var increase_darkness = false
var decrease_darkness = false
var time = 0
onready var light : OmniLight
# Called when the node enters the scene tree for the first time.
func _ready():
	light = $OmniLight


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if increase_darkness:
		light.omni_range = lerp(0.7,3,time)
		time += delta
		if time > 1:
			increase_darkness = false
			time = 0
	if decrease_darkness:
		light.omni_range = lerp(3,0.7,time)
		time += delta
		if time > 1:
			decrease_darkness = false
			time = 0
			

func _on_Area_mouse_entered():
	pass#increase_darkness = true


func _on_Area_mouse_exited():
	pass#decrease_darkness = true


func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		get_tree().change_scene("res://Scenes/Space.tscn")
