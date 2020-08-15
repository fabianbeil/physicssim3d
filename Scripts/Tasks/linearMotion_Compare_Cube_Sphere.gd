extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var UI:Node

# Called when the node enters the scene tree for the first time.
func _ready():
	UI = get_tree().get_nodes_in_group("TaskUI")[0]
	UI.set_type("lineare Bewegung: Kugel und Würfel im Vergleich")
	UI.set_desc("Masse: 1kg")
	UI.set_hint("Klicken und Halten zum Anschieben")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
