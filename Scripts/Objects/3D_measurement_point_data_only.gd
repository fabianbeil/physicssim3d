extends Spatial


# Declare member variables here. Examples:
# var a = 2
export var include_z = false
export var swap_yz = false
onready var material_green = preload("res://Materials/SpatialMaterials/BrightGreen.tres")
var measurement_position = Vector3(0,0,0)
var measurement_time = 0
var y = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func set_coordinates(x,y,z,t):
	if swap_yz:
		var y_hilf = y
		y = z
		z = y_hilf
	measurement_position = Vector3(x,y,z)
	measurement_time = t
	
func set_color(color_index):
	if color_index == 1:
		$MeshInstance.set_surface_material(0,material_green)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
