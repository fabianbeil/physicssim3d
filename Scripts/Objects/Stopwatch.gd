extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var elapsed_time = 0.0
var distance_to_origin = 0.0
var running = false
onready var timedisplay = get_node("Knoepfe_und_Display/TimeDisplay")
onready var distance_display = get_node("Knoepfe_und_Display/DistanceDisplay")
#onready var camera = get_tree().get_nodes_in_group("CameraBody")[0]

var auto = false
var origin: Spatial
var distance_measurement = false
var dragging = false
# Called when the node enters the scene tree for the first time.
func _ready():
	timedisplay.set_text("0 s")

func start_watch():
	running = true

func stop_watch():
	running = false

func set_distance_true(starter:Spatial):
	distance_measurement = true
	origin = starter

func reset_watch():
	elapsed_time = 0
	timedisplay.set_text(str(round(elapsed_time*100)/100) + " s")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if distance_measurement:
		var current_distance = round((transform.origin - origin.transform.origin).length()*1000)/1000
		distance_display.set_text(str(current_distance) +" m")
		
	if running:
		elapsed_time += delta
		timedisplay.set_text(str(round(elapsed_time*100)/100) + " s")
		

func start_auto():
	stop_watch()
	reset_watch()
	auto = true
	start_watch()
		
	

func _on_StartButton_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		start_watch()


func _on_StopButton_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		stop_watch()


func _on_ResetButton_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		reset_watch()


func _on_Area_body_entered(body):
	if auto:
		stop_watch()


func _on_SlideHandle_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			dragging = true
		if event.is_action_released("left_click"):
			dragging = false
	if event is InputEventMouseMotion and dragging:
		var from = camera.project_ray_origin(event.position)
		var direction = camera.project_ray_normal(event.position)
		var ray_parameter = -from.y/direction.y
		var x_of_height_zero = (from + ray_parameter*direction).x
		transform.origin.x = x_of_height_zero


func _on_Area_area_entered(area):
	if auto:
		stop_watch()
