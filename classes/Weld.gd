class_name Weld extends Node2D

func _ready():
	var joint1 = PinJoint2D.new()
	joint1.node_a = Game.buffer[0][0]
	joint1.node_b = Game.buffer[1][0]
	joint1.global_position = Game.buffer[0][1]
	
	var joint2 = PinJoint2D.new()
	joint2.node_a = Game.buffer[1][0]
	joint2.node_b = Game.buffer[0][0]
	joint2.global_position = Game.buffer[1][1]
	
	add_child(joint1)
	add_child(joint2)
