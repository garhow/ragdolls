class_name GenericVehicle extends Draggable

var driving := false

@export var torque: float

@export var rear_wheel_body: RigidBody2D
@export var front_wheel_body: RigidBody2D

func _interact():
	if driving:
		rear_wheel_body.constant_torque = 0
		front_wheel_body.constant_torque = 0
	elif !driving:
		rear_wheel_body.add_constant_torque(torque * 100)
		front_wheel_body.add_constant_torque(torque * 100)
	driving = !driving
