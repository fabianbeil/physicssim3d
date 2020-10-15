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
var TaskUI: Control
var click_or_release = "click"
export var scroll_speed = 0.3
export var mouse_sensitivity = 0.3
export var key_sensitivity = .1


# Called when the node enters the scene tree for the first time.
func _ready():
	FPS_Cam = get_tree().get_nodes_in_group("Camera")[0]
	FPS_Body = get_tree().get_nodes_in_group("CameraBody")[0]
	if len(get_tree().get_nodes_in_group("TaskUI")) > 0:
		TaskUI = get_tree().get_nodes_in_group("TaskUI")[0]
	set_mouse_view("fly")
	
func shoot_click_ray():
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(click_ray_from, click_ray_to, [self, FPS_Body])
	if result:
		var RB_Parent = result.collider.get_parent()
		print_debug(RB_Parent)
		if RB_Parent.has_method("click") and click_or_release == "click":
			RB_Parent.click()
		if RB_Parent.has_method("release") and click_or_release == "release":
			RB_Parent.release()

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
		
					
		
	#if event is InputEventMouseButton and event.is_pressed() and Input.get_mouse_mode() == 2 and event.button_index == BUTTON_LEFT:
	#	toggle_mouse_view()
		
	if event is InputEventMouseButton and event.is_action_pressed("left_click"): #and Input.get_mouse_mode() == 0
		click_ray_from = FPS_Cam.project_ray_origin(event.position)
		click_ray_to = click_ray_from + FPS_Cam.project_ray_normal(event.position) * ray_length
		click_or_release = "click"
		click_ray = true
	
	if event is InputEventMouseButton and event.is_action_released("left_click"): #and Input.get_mouse_mode() == 0
		click_ray_from = FPS_Cam.project_ray_origin(event.position)
		click_ray_to = click_ray_from + FPS_Cam.project_ray_normal(event.position) * ray_length
		click_or_release = "release"
		click_ray = true	
	if event is InputEventMouseButton and event.is_pressed() and Input.get_mouse_mode() == 2 and event.button_index == BUTTON_WHEEL_UP:
		mouse_sensitivity = min(1,mouse_sensitivity + 0.01)
		key_sensitivity = min(1,key_sensitivity + 0.01)
	if event is InputEventMouseButton and event.is_pressed() and Input.get_mouse_mode() == 2 and event.button_index == BUTTON_WHEEL_DOWN:
		key_sensitivity = max(0,key_sensitivity - 0.01)
		mouse_sensitivity = max(0,mouse_sensitivity - 0.01)
			
	if event.is_action_pressed("toggle_mouse"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			set_mouse_view("fly")
		else:
			set_mouse_view("mouse")
	
	if event.is_action_pressed("toggle_zoom"):
		toggle_zoom()
		
	
	

func toggle_zoom():
	if FPS_Cam.fov == 80:
		FPS_Cam.fov = 20
	else:
		FPS_Cam.fov = 80
		
func set_mouse_view(mode):
	if mode == "fly":
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if TaskUI != null:
			TaskUI.haircross(true)
	elif mode == "mouse":
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if TaskUI != null:
			TaskUI.haircross(false)
		

