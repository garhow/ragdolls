class_name Draggable
extends RigidBody2D

var dragging := false
var hovering := false

var current_joint : PinJoint2D
var current_pivot : PhysicsBody2D

func _ready():
	input_pickable = true
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _interact():
	pass

func _process(_delta):
	if hovering:
		modulate = Color8(255, 255, 255, 100)
	elif freeze:
		modulate = Color.SKY_BLUE
	else: modulate = Color.WHITE

func _physics_process(_delta):
	if Input.is_action_just_pressed("click") and hovering: dragging = true
	if Input.is_action_just_released("click"): dragging = false
	
	if dragging:
		if !current_pivot and !current_joint:
			var pivot = StaticBody2D.new()
			add_child(pivot)
			
			var joint = PinJoint2D.new()
			joint.node_a = pivot.get_path()
			joint.node_b = self.get_path()
			joint.softness = 1.05
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
		
	
	if Input.is_action_just_pressed("freeze") and (hovering or dragging): freeze = !freeze
	if Input.is_action_just_pressed("interact") and (hovering or dragging): _interact()

func _on_mouse_entered(): hovering = true
func _on_mouse_exited(): hovering = false