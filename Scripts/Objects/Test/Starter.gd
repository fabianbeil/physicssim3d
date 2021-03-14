extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var elapsed_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	elapsed_time += delta
	transform.origin = Vector3(0,3*sin(4*elapsed_time),0)
