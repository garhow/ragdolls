extends VBoxContainer

@export var pistol_scene : PackedScene
@export var human_scene : PackedScene
@export var snake_scene : PackedScene
@export var ball_scene : PackedScene

func _on_pistol_pressed(): Game.selected_object = pistol_scene
func _on_human_pressed(): Game.selected_object = human_scene
func _on_snake_pressed(): Game.selected_object = snake_scene
func _on_ball_pressed(): Game.selected_object = ball_scene
