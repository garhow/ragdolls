extends Camera2D

const MIN_ZOOM := 0.5
const MAX_ZOOM := 2.0
const ZOOM_INCREMENT := 0.1

var target_zoom := 1.0

func _input(event):
	if Input.is_action_just_pressed("spawn"):
		if Game.selected_object:
			var object = Game.selected_object.instantiate()
			object.global_position = get_global_mouse_position()
			get_tree().current_scene.add_child(object)
	
	# Zooming using the scroll wheel
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_in()
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_out()
	
	# Camera panning using the middle mouse button
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			position -= event.relative / target_zoom

func _physics_process(delta: float) -> void:
	zoom = lerp(zoom, target_zoom * Vector2.ONE, 8 * delta)
	set_physics_process(not is_equal_approx(zoom.x, target_zoom))

func zoom_in() -> void:
	target_zoom = clamp(target_zoom + ZOOM_INCREMENT, MIN_ZOOM, MAX_ZOOM)
	set_physics_process(true)

func zoom_out() -> void:
	target_zoom = clamp(target_zoom - ZOOM_INCREMENT, MIN_ZOOM, MAX_ZOOM)
	set_physics_process(true)
