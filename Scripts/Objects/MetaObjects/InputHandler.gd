extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var FPS_Cam: Camera
var FPS_Body: KinematicBody
var fps_direction = Vector3()
var fps_basis = Vector3()
var ray_length = 1000
var click_ray = false
var click_ray_from: Vector3
var click_ray_to: Vector3
export var scroll_speed = 0.3
export var mouse_sensitivity = 0.3
export var key_sensitivity = .1


# Called when the node enters the scene tree for the first time.
func _ready():
	FPS_Cam = get_tree().get_nodes_in_group("Camera")[0]
	FPS_Body = get_tree().get_nodes_in_group("CameraBody")[0]
	
	
func shoot_click_ray():
	pass
#	var space_state = get_world().direct_space_state
#	var result = space_state.intersect_ray(click_ray_from, click_ray_to, [self, FPS_Body])
#	if result:
#		print_debug(result.collider)
#	else:
#		print_debug("Nix_Getroffen")

func _physics_process(delta):
	if click_ray:
		shoot_click_ray()
		click_ray = false
	fps_basis = FPS_Cam.transform.basis
	if Input.get_mouse_mode() == 2:
		if Input.is_action_pressed("move_forward"):
				fps_direction -= fps_basis.z
		if Input.is_action_pressed("move_backward"):
				fps_direction += fps_basis.z
		if Input.is_action_pressed("move_left") :
				fps_direction -= fps_basis.x
		if Input.is_action_pressed("move_right"):
				fps_direction += fps_basis.x
		if Input.is_action_pressed("move_up"):
				fps_direction -= fps_basis.y
		if Input.is_action_pressed("move_down"):
				fps_direction += fps_basis.y
		fps_direction = fps_direction.normalized()
		FPS_Body.translate(fps_direction*key_sensitivity)
	fps_direction = Vector3(00,0,0)
	
func _input(event):
	####################### Toggle Camera Viewport
	if Input.get_mouse_mode() == 2:
		if event is InputEventMouseMotion:
			FPS_Body.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
			var x_delta = event.relative.y * mouse_sensitivity
			if FPS_Cam.rotation_degrees.x-x_delta < 90 and FPS_Cam.rotation_degrees.x-x_delta > -90:
				FPS_Cam.rotate_x(deg2rad(-x_delta))
		
					
		
	if event is InputEventMouseButton and event.is_pressed() and Input.get_mouse_mode() == 2 and event.button_index == BUTTON_LEFT:
		toggle_mouse_view()
		
	if event is InputEventMouseButton and event.is_pressed() and Input.get_mouse_mode() == 0 and event.button_index == BUTTON_LEFT:
		click_ray_from = FPS_Cam.project_ray_origin(event.position)
		click_ray_to = click_ray_from + FPS_Cam.project_ray_normal(event.position) * ray_length
		click_ray = true
			
	if event.is_action_pressed("toggle_mouse"):
		toggle_mouse_view()
		
	
	


func toggle_mouse_view():
	if Input.get_mouse_mode() == 0:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif Input.get_mouse_mode() == 2:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		

