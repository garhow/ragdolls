extends Node2D

var slow_motion: bool

@export var lift: Area2D
@export var pull: Area2D
@export var push: Area2D

signal pause_toggled
signal slow_motion_toggled

func _process(_delta):
	if Input.is_action_just_pressed("spawn"):
		if Game.selected_object:
			var object = Game.selected_object.instantiate()
			object.global_position = get_global_mouse_position()
			get_tree().current_scene.add_child(object)
			
			var sound = AudioStreamPlayer2D.new()
			sound.stream = preload("res://sounds/spawn.ogg")
			sound.global_position = get_global_mouse_position()
			add_child(sound)
			sound.play()
	
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		emit_signal("pause_toggled")
	
	if Input.is_action_just_pressed("slow_motion"):
		if slow_motion:
			Engine.time_scale = 1
		elif !slow_motion:
			Engine.time_scale = 0.2
			
		slow_motion = !slow_motion
		emit_signal("slow_motion_toggled")

func _handle_pull_push(area: Area2D, tool: Game.Tools):
	if Input.is_action_pressed("click") and Game.tool == tool:
		area.global_position = get_global_mouse_position()
		area.gravity_space_override = Area2D.SPACE_OVERRIDE_COMBINE_REPLACE
		area.linear_damp_space_override = Area2D.SPACE_OVERRIDE_COMBINE_REPLACE
	else:
		area.gravity_space_override = Area2D.SPACE_OVERRIDE_DISABLED
		area.linear_damp_space_override = Area2D.SPACE_OVERRIDE_DISABLED

func _physics_process(_delta):
	_handle_pull_push(lift, Game.Tools.LIFT)
	_handle_pull_push(pull, Game.Tools.PULL)
	_handle_pull_push(push, Game.Tools.PUSH)
