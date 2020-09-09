extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var push = 0
var go = 0
var spawn_measurements = false
var time = 0
onready var measureemt_point = preload("res://Scenes/Objects/3D_measurement_point.tscn")
var number_of_points = 15
var measurement_points = []
var number_of_current_point = 0
export var time_between_measurements = 0.075
export var measurement_point_rotation = Vector3(0,0,0)
export var deltaforce = 1
export var maxforce = 500
var force = 0
var UI: Node
onready var direction = transform.basis.x.normalized()
var total_time = 0
var this_scale = 1
var StartingPoint: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	$RigidBody.set_mode(RigidBody.MODE_STATIC)
	for q in range(number_of_points):
		var new_point = measureemt_point.instance()
		new_point.visible = false
		new_point.scale = new_point.scale * 2
		new_point.rotation_degrees = measurement_point_rotation
		add_child(new_point)
		measurement_points.append(new_point)
	this_scale = transform.basis.get_scale().x
	UI = get_tree().get_nodes_in_group("TaskUI")[0]
		
	
func _physics_process(delta):
	if spawn_measurements and number_of_current_point < number_of_points:
		time = time + delta
		total_time = total_time + delta
		if time > time_between_measurements:
			time = 0
			spawn_measurement_point()
	if push == 1:
		increase_force()
		UI.set_force(force,maxforce)
	if go:
		$RigidBody.add_central_force(direction*force)
		UI.set_force(0,1)
		go = 0
		StartingPoint = transform.origin
	

func _on_RigidBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			push = 1 
		if event.is_action_released("left_click"):
			$RigidBody.set_mode(RigidBody.MODE_RIGID)
			spawn_measurements = true
			push = 0
			go = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func spawn_measurement_point():
	var this_point = measurement_points[number_of_current_point]
	var current_position = $RigidBody.transform.origin
	this_point.transform.origin = current_position
	this_point.visible = true
	this_point.set_coordinates((current_position.x-StartingPoint.x)*this_scale,(current_position.y-StartingPoint.y)*this_scale,(current_position.z-StartingPoint.z)*this_scale,total_time)
	number_of_current_point += 1

func increase_force():
	force = min(force+deltaforce,maxforce)
