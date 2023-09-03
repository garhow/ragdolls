extends Control

@export var map_grid: GridContainer

func _ready():
	for map in Game.maps.values():
		create_button(map)

func create_button(map: Dictionary) -> void:
	var button = Button.new()
	button.text = map.get("name")
	button.pressed.connect(_select_map.bind(map))
	map_grid.add_child(button)

func _select_map(map: Dictionary) -> void:
	get_tree().change_scene_to_packed(map.get("resource"))
