extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var experiment: NodePath
var experiment_path: String
var experiment_node: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	experiment_path = get_node(experiment).filename
	
	
func release():
	do_the_reset()

func do_the_reset():
	var old_experiment = get_node(experiment)
	var old_position = old_experiment.transform.origin
	var old_scale = old_experiment.transform.basis.get_scale()
	old_experiment.queue_free()
	var new_experiment_scene = load(experiment_path)
	var new_experiment = new_experiment_scene.instance()
	self.get_parent().add_child(new_experiment)
	new_experiment.transform.origin = old_position
	new_experiment.scale = old_scale
	experiment = new_experiment.get_path()
	
func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event.is_action_pressed("left_click"):
		do_the_reset()
