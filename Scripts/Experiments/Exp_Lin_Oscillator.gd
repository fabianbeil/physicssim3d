extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Spring = get_node("Area")
var body_in = false
var RB_Ball: RigidBody
export var elastic_constant = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if body_in:
		var distance = RB_Ball.transform.origin - Spring.transform.origin
		RB_Ball.add_central_force(-elastic_constant*distance)
func _on_Area_body_entered(body):
	if body is RigidBody and body.is_in_group("PhysicsObject"):
		print_debug("do isser")
		RB_Ball = body
		body_in = true
		
		
