extends Node2D

## How many segments the snake has.
@export_range(1, 48) var segments := 5

@onready var segment: RigidBody2D = $Segment
@onready var current_segment = segment

func _ready():
	current_segment = segment
	for i in segments:
		var new_segment: RigidBody2D = current_segment.duplicate()
		new_segment.position.x += 16
		add_child(new_segment)
		
		var pin = PinJoint2D.new()
		pin.node_a = current_segment.get_path()
		pin.node_b = new_segment.get_path()
		pin.position.x += current_segment.position.x + 8
		add_child(pin)
		
		current_segment = new_segment
