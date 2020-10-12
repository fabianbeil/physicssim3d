extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var jump_size = 0.15
var elapsed_time = 0.0
onready var Video = get_node("VideoPlayer")
var moved = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Video.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed_time += delta
	if elapsed_time > jump_size:
		Video.paused = true
		elapsed_time = 0
	if moved:
		Video.paused = false
		moved = false

func _on_Button_pressed():
	print_debug(Video.stream_position)
	moved = true
