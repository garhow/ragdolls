class_name Draggable extends RigidBody2D

@export var flippable := false

@onready var default_gravity = self.gravity_scale

var dragging := false
var hovering := false

var current_joint : PinJoint2D
var current_pivot : PhysicsBody2D

func play_sound(path: Resource):
	var sound = AudioStreamPlayer2D.new()
	sound.stream = path
	sound.global_position = global_position
	add_child(sound)
	sound.play()

func _ready():
	input_pickable = true
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	play_sound(preload("res://sounds/spawn.ogg"))

func _interact():
	pass

func _flip():
	if flippable:
		for child in get_children():
			child.scale.x = -1

func _antigravity():
	play_sound(load("res://sounds/gravity.ogg"))
	if gravity_scale == default_gravity:
		gravity_scale = -1
	else:
		gravity_scale = default_gravity

func _pin():
	Game.spawn(Pin.new(self))

func _weld():
	if Game.buffer_tool != Game.Tools.WELD:
		Game.buffer_tool = Game.Tools.WELD
		Game.buffer.clear()
	if Game.buffer.size() == 0:
		Game.buffer.append([self.get_path(), get_global_mouse_position()])
		play_sound(load("res://sounds/weld1.ogg"))
	else:
		Game.buffer.append([self.get_path(), get_global_mouse_position()])
		play_sound(load("res://sounds/weld2.ogg"))
		
		Game.spawn(Weld.new())
		Game.buffer.clear()

func _handle_dragging():
	if Game.tool == Game.Tools.DRAG:
		if Input.is_action_just_pressed("click") and hovering: dragging = true
		if Input.is_action_just_released("click"): dragging = false
		
		if dragging:
			if !current_pivot and !current_joint:
				var pivot = StaticBody2D.new()
				add_child(pivot)
				
				var joint = PinJoint2D.new()
				joint.node_a = pivot.get_path()
				joint.node_b = self.get_path()
				joint.softness = 0.1
				joint.position = get_local_mouse_position()
				add_child(joint)
				
				current_joint = joint
				current_pivot = pivot
			current_pivot.position = get_local_mouse_position()
		else:
			if current_joint:
				current_joint.queue_free()
				current_joint = null
			if current_pivot:
				current_pivot.queue_free()
				current_pivot = null

func _process(_delta):
	# Handle inputs
	if hovering or dragging:
		if Input.is_action_just_pressed("freeze"): freeze = !freeze
		if Input.is_action_just_pressed("interact"): _interact()
		if Input.is_action_just_pressed("delete"): queue_free()
		if Input.is_action_just_pressed("flip"): _flip()
		if Input.is_action_just_pressed("click") and Game.tool == Game.Tools.ANTIGRAVITY: _antigravity()
		if Input.is_action_just_pressed("click") and Game.tool == Game.Tools.PIN: _pin()
		if Input.is_action_just_pressed("click") and Game.tool == Game.Tools.WELD: _weld()
	
	# Handle modulation
	if hovering:
		modulate = Color8(255, 255, 255, 100)
	elif freeze:
		modulate = Color.SKY_BLUE
	else: modulate = Color.WHITE

func _physics_process(_delta):
	_handle_dragging()
	_custom_physics_process(_delta)
	if global_position.x < -Game.world_size or global_position.x > Game.world_size or global_position.y < -Game.world_size or global_position.y > Game.world_size:
		queue_free()

func _custom_physics_process(_delta):
	pass

func _on_mouse_entered(): hovering = true
func _on_mouse_exited(): hovering = false
