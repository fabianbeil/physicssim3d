extends Spatial


# Declare member variables here. Examples:
# var a = 2
export var include_z = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if not include_z:
		$PositionDisplay_z.visible = false
func set_coordinates(x,y,z,t):
	$PositionDisplay_x.set_text("x: "+"%.3f"%x +"m")
	$PositionDisplay_y.set_text("y: "+ "%.3f"%y +"m")
	$PositionDisplay_z.set_text("z: "+ "%.3f"%z +"m")
	
	$TimeDisplay.set_text("t: "+ "%.2f"%t +"s")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
