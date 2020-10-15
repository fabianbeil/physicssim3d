extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var uhren = []
var starter: Node
var ready = false
export var auto = true


func _ready():
	var children = get_children()
	for node in children:
		if node.is_in_group("Uhren"):
			uhren.append(node)
		if node.is_in_group("Origin"):
			starter = node
	#print_debug(starter)
	if starter != null:
		starter.connect("start_measuring", self, "_on_start_measuring")
		for uhr in uhren:
			uhr.set_distance_true(starter)
		


func set_all_watches_auto():
	for uhr in uhren:
		uhr.start_auto()

func reset_all_watches():
	for uhr in uhren:
		uhr.reset_watch()
		
func start_all_watches():
	if ready:
		for uhr in uhren:
			uhr.start_watch()
		ready = false


func _on_ButtonReady_button_clicked():
	print_debug("ready")
	set_all_watches_auto()
	ready = true


func _on_ButtonReset_button_clicked():
	print_debug("reset")
	reset_all_watches()

func _on_start_measuring():
	set_all_watches_auto()
