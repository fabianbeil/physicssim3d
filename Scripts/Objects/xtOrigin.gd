extends Spatial

signal start_measuring
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Area_body_entered(body):
	if body.is_in_group("PhysicsObject"):
		emit_signal("start_measuring")
