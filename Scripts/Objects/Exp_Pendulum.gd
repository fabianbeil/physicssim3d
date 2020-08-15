extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var mass = 1.0
export var length = 1.0
export var start_at_angle = -45.0

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_start_position(0)
	

func reset_start_position(angle):
	var thread_vector = length * Vector3.DOWN.rotated(Vector3.FORWARD,angle/180*PI)
	for RB in get_children():
		if RB is RigidBody:
			RB.linear_velocity = Vector3(0,0,0)
	$Pendulum_Hook.transform.origin = transform.origin + Vector3.UP * length
	$Joint_Hook_Mass.transform.origin = transform.origin + Vector3.UP *length
	$Mass.transform.origin = $Pendulum_Hook.transform.origin + thread_vector
	
func _physics_process(delta):
	if InputEventAction:
		if Input.is_action_pressed("ui_accept"):
			reset_start_position(start_at_angle)
			
	$Mass/Thread.transform.origin = transform.origin + (($Pendulum_Hook.transform.origin-transform.origin) - ($Mass.transform.origin-transform.origin) *0.5)

