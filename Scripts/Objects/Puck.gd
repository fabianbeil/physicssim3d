extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var push = false
var direction = Vector3(0,0,0)
var force_magnitude = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if push:
		$RigidBody.add_central_force(direction*force_magnitude)
		push = false


func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			direction = ($RigidBody.transform.origin - Vector3(click_position.x,$RigidBody.transform.origin.y,click_position.z)).normalized()
			push = true
