extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var push = 0
var go = 0
var spawn_measurements = false
var time = 0
onready var measurement_point = preload("res://Scenes/Objects/3D_measurement_point.tscn")
onready var measurement_point_dataonly = preload("res://Scenes/Objects/3D_measurement_point_Data_only.tscn")
export var no_labels: bool
export var number_of_points = 15
var measurement_points = []
var number_of_current_point = 0
export var time_between_measurements = 0.075
export var measurement_point_rotation = Vector3(0,0,0)
export var deltaforce = 1
export var maxforce = 500
var force = 0
var UI: Node
onready var direction = transform.basis.x.normalized()
export var Force_Direction =  Vector3(1,0,0)
var total_time = 0
var this_scale = 1
# Stuff to allow measurement relative to an arbitrary origin
var StartingPoint: Vector3
export var relative = false # If false, measurements are relative to the position of the ball when released
export var relative_to: NodePath
export var swap_yz_on_points = false
# Enables being able to be kicked by other ball ( or PhysicsObject)
export var passive = false
# Starts measurement again after a collision
export var aller_retour = false
var second_round = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if aller_retour:
		number_of_points *= 2
	$RigidBody.set_mode(RigidBody.MODE_STATIC)
	prepare_measurement_points()
	this_scale = transform.basis.get_scale().x
	UI = get_tree().get_nodes_in_group("TaskUI")[0]
	
func click():
	push = 1 
	
func release():
	$RigidBody.set_mode(RigidBody.MODE_RIGID)
	spawn_measurements = true
	push = 0
	go = 1

func release_passive():
	$RigidBody.set_mode(RigidBody.MODE_RIGID)
	spawn_measurements = true

func prepare_measurement_points():
	for q in range(number_of_points):
		var new_point: Node
		if !no_labels:
			new_point = measurement_point.instance()
		else:
			new_point = measurement_point_dataonly.instance()
			print_debug("use_dataonly")
		new_point.visible = false
		new_point.scale = new_point.scale * 2
		if swap_yz_on_points:
			new_point.swap_yz = true
		add_child(new_point)
		measurement_points.append(new_point)

func _physics_process(delta):
	var max_number_of_points = 0
	if aller_retour:
		max_number_of_points = number_of_points / 2
		if second_round:
			max_number_of_points = number_of_points
	else:
		max_number_of_points = number_of_points
	if spawn_measurements and number_of_current_point < max_number_of_points:
		time = time + delta
		total_time = total_time + delta
		if time > time_between_measurements:
			time = 0
			spawn_measurement_point()
	else:
		spawn_measurements = false
	if push == 1:
		increase_force()
		UI.set_force(force,maxforce)
	if go:
		$RigidBody.add_central_force(Force_Direction*force)
		UI.set_force(0,1)
		go = 0
		if relative:
			StartingPoint = get_node(relative_to).transform.origin
		else:
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
	this_point.rotation_degrees = measurement_point_rotation
	this_point.visible = true
	if passive:
		this_point.set_color(1)
	this_point.set_coordinates((current_position.x-StartingPoint.x)*this_scale,(current_position.y-StartingPoint.y)*this_scale,(current_position.z-StartingPoint.z)*this_scale,total_time)
	number_of_current_point += 1
	if aller_retour and number_of_current_point > number_of_points:
		spawn_measurements = false

func increase_force():
	force = min(force+deltaforce,maxforce)


func _on_Area_body_entered(body):
	if body.is_in_group("PhysicsObject") and body != $RigidBody and passive:
		self.release_passive()
	if body.is_in_group("PhysicsObject") and body != $RigidBody and aller_retour:
		second_round = true
		spawn_measurements = true

