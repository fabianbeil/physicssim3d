extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Other_Oscillators = []
onready var RB = get_node("RigidBody")
export var elastic_constant = 3.0
export var coupling_constant = 1.0
#export var nextbody = []
var elongation = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func sqr(fac:float):
	return fac*fac

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	elongation = self.transform.origin.y - RB.transform.origin.y
	RB.add_central_force(Vector3.UP*elongation*elastic_constant)
	if len(Other_Oscillators) > 0:
		for current_body in Other_Oscillators:
			var difference_elongation = RB.transform.origin.y - current_body.transform.origin.y
			current_body.add_central_force(Vector3.UP*difference_elongation*coupling_constant)


func _on_Coupling_body_entered(body):
	if body is RigidBody and body.is_in_group("Oscillator") and body != RB and !(body in Other_Oscillators):
		print_debug("boink")
		Other_Oscillators.append(body)
		
