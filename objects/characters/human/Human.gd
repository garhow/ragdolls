extends Node2D

@onready var body_parts = [$Head, $Torso, $"Left Leg", $"Right Leg", $"Left Arm", $"Right Arm"]

func _flip():
	for body_part in body_parts:
		for child in body_part.get_children():
			child.scale.x = -1
