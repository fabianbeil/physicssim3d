extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var force = 0
var go = 0
var UI: Node
var push = 0


export var deltaforce = 1
export var maxforce = 500
export var type = "Würfel"
var initial_transform: Transform



onready var connected_object = get_node("RigidBody")
onready var direction = transform.basis.x.normalized()

# Called when the node enters the scene tree for the first time.
func _ready():
	UI = get_tree().get_nodes_in_group("TaskUI")[0]
	
	#UI.set_force(0,1)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if push == 1:
		increase_force()
		UI.set_force(force,maxforce)
	if go:
		connected_object.add_central_force(direction*force)
		UI.set_force(0,1)
		go = 0
	
		
func increase_force():
	force = min(force+deltaforce,maxforce)
	
		
func _on_RigidBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			push = 1 
		if event.is_action_released("left_click"):
			push = 0
			go = 1
			UI.set_force(0,1)
	
		
