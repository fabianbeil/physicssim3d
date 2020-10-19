extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var passes = 0
onready var display = preload("res://Scenes/Objects/DigitalDisplay.tscn")
var elapsed_time = 0.0
var times = []
var time_displays = []
var even = true
onready var display_mean = $display_mean
# Called when the node enters the scene tree for the first time.
func _ready():
	add_displays()

func add_displays():
	for n in range(15):
		var current_time_display = display.instance()
		add_child(current_time_display)
		current_time_display.set_text("")
		current_time_display.rotate_x(-PI/2)
		current_time_display.translate(Vector3(0,-1.5-3*n/10.0,0))
		time_displays.append(current_time_display)	
		
func mark_time():
	var current_time = round(elapsed_time*100)/100
	times.append(current_time)
	if len(times)<=len(time_displays) and len(times) > 0:
		time_displays[len(times)-1].set_text(str(current_time)+"s")
	if len(times) > 0:
		display_mean.set_text(str(round(times[len(times)-1]/len(times)*1000)/1000)+"s")

func _physics_process(delta):
	if passes > 0:
		elapsed_time += delta

func _on_Area_area_entered(area):
	if area.is_in_group("StopWatchTrigger"):
		if passes > 0 and even:
			mark_time()
		passes +=1
		even = !even
