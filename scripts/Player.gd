extends Node2D

signal pause_toggled

func _input(_event):
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
