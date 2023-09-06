extends CanvasLayer

@export var player: Node2D

@export var pause_indicator: Label
@export var slow_motion_indicator: Label

@export var creature_grid: GridContainer
@export var misc_grid: GridContainer
@export var weapon_grid: GridContainer
@export var vehicle_grid: GridContainer

func _ready() -> void:
	prepare_spawnlist()
	pause_indicator.visible = false
	slow_motion_indicator.visible = false
	player.connect("pause_toggled", _on_pause_toggled)
	player.connect("slow_motion_toggled", _on_slow_motion_toggled)

func _on_pause_toggled():
	if get_tree().paused:
		pause_indicator.visible = true
	elif !get_tree().paused:
		pause_indicator.visible = false

func _on_slow_motion_toggled():
	if Engine.time_scale == 1:
		slow_motion_indicator.visible = false
	else:
		slow_motion_indicator.visible = true

func prepare_spawnlist() -> void:
	for creature in Game.spawnlist.get("creatures").values():
		create_button(creature, creature_grid)
	for object in Game.spawnlist.get("miscellaneous").values():
		create_button(object, misc_grid)
	for weapon in Game.spawnlist.get("weapons").values():
		create_button(weapon, weapon_grid)
	for vehicle in Game.spawnlist.get("vehicles").values():
		create_button(vehicle, vehicle_grid)

func create_button(object: Dictionary, grid: GridContainer) -> void:
	var button = Button.new()
	button.text = object.get("name")
	button.pressed.connect(_select_object.bind(object))
	grid.add_child(button)

func _select_object(object: Dictionary) -> void:
	Game.selected_object = object.get("resource")

func _on_tool_picked(extra_arg_0):
	Game.tool = extra_arg_0
