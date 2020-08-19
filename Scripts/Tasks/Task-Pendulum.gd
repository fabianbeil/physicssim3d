extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var UI: Node
# Called when the node enters the scene tree for the first time.
func _ready():
	UI = get_tree().get_nodes_in_group("TaskUI")[0]
	UI.set_type("Fadenpendel")
	UI.set_desc("Masse 1kg, Fadenlänge: 2m, Auslenkung zu Beginn: 10°")
	UI.set_hint("Die Zeiten werden ab den ersten Durchgang durch die Lichtschranke berechnet")
	UI.hide_force_bar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
