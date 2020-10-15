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
	get_node(experiment).queue_free()
	var new_experiment_scene = load(experiment_path)
	var new_experiment = new_experiment_scene.instance()
	#experiment = new_experiment.get_path()
	self.get_parent().add_child(new_experiment)

func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event.is_action_pressed("left_click"):
		do_the_reset()
