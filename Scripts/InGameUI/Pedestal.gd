extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var Path_to_Scene: String
var scene_to_load: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	scene_to_load = load(Path_to_Scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func release():
	get_tree().change_scene(Path_to_Scene)


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	release()
