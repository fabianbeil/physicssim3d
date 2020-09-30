extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var PhysicsObject: RigidBody
var use_the_force = false
export var ClickBall_Object: NodePath
var ClickBall: Node
# Called when the node enters the scene tree for the first time.
func _ready():
	ClickBall = get_node(ClickBall_Object)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if use_the_force:
		var distance_vec = -(transform.origin-PhysicsObject.transform.origin)
		var distance = distance_vec.length()
		var direction = distance_vec.normalized()
		ClickBall.measurement_point_rotation = Vector3(90,90+direction.angle_to(Vector3(1,0,0))/PI*360,0)

func _on_CentralForceArea_body_entered(body):
	if body is RigidBody:
		if body.is_in_group("PhysicsObject"):
			PhysicsObject = body
			use_the_force = true
			
