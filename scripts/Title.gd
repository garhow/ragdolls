extends Control

@export var version_label: Label

@export var logo_body: StaticBody2D
@export var logo_control: TextureRect

@export var menu_body: StaticBody2D
@export var menu_control: Control

func _ready():
	version_label.text = "v" + str(Game.VERSION)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://ui/MapSelection.tscn")

func _on_options_pressed():
	Game.play_sound(load("res://sounds/error.ogg"))

func _on_quit_pressed():
	get_tree().quit()

func _spawn_object():
	var human: Node2D = Game.spawnlist.get("creatures").get("human").get("resource").instantiate()
	human.global_position = Vector2(randf_range(0, get_viewport().size.x), -128)
	human.rotation_degrees = -90
	add_child(human)

func _process(_delta):
	logo_body.global_position = logo_control.global_position + logo_control.size / 2
	menu_body.global_position = menu_control.global_position + menu_control.size / 2
