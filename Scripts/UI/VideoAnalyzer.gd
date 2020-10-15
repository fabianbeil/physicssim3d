extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var jump_size = 0.15
var elapsed_time = 0.0
onready var Video = get_node("VideoPlayer")
onready var TRect = get_node("TextureRect")
var moved = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Video.play()
	Video.paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if !Video.is_playing():
	#	Video.play()

func _on_Button_pressed():
	print_debug(Video.stream_position)
	Video.paused = false
	$Timer.start()
	


func _on_Timer_timeout():
	Video.paused = true
	TRect.texture = Video.get_video_texture()
	print_debug(Video.stream_position)
