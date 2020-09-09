extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btn_exit_pressed():
	get_tree().quit()


func _on_btn_lin_cube_pressed():
	get_tree().change_scene("res://Scenes/Tasks/1BodyLinearMotion.tscn")


func _on_btn_lin_ball_pressed():
	get_tree().change_scene("res://Scenes/Tasks/1BodyLinearMotion_sphere.tscn")


func _on_btn_lin_both_pressed():
	get_tree().change_scene("res://Scenes/Tasks/linearMotion_Compare_Cube_Sphere.tscn")


func _on_btn_pendulum1_pressed():
	get_tree().change_scene("res://Scenes/Tasks/Task-Pendulum.tscn")



func _on_btn_linear_accelereation_pressed():
	get_tree().change_scene("res://Scenes/Tasks/Task_tilted_Ramp.tscn")


func _on_btn_ball_throw_pressed():
	get_tree().change_scene("res://Scenes/Tasks/Task_BallThrow.tscn")
