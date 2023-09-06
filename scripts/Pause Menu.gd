extends Control

func _ready():
	visible = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		visible = !visible

func _resume():
	visible = false

func _return_to_title():
	get_tree().change_scene_to_file("res://ui/title.tscn")

func _quit_game():
	get_tree().quit()
