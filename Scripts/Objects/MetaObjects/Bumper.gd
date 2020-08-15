extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var push = 0
var BodyToPush
export var force = 50
onready var direction = get_node("..").transform.basis.x.normalized()

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug(direction)


func _physics_process(delta):
	if push == 1 and BodyToPush != null:
		BodyToPush.add_central_force(direction*force)
		push = 0
		BodyToPush = null


func _on_Area_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		push = 1


func _on_BumperBody_body_entered(body):
	if body is RigidBody:
		print_debug(body)
		BodyToPush = body
	

func _on_BumperBody_body_exited(body):
	if body is RigidBody:
		BodyToPush == null
