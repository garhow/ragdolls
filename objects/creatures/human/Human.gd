extends Creature

@export_category("Body Parts")
@export var head: Draggable
@export var upper_torso: Draggable
@export var lower_torso: Draggable
@export var waist: Draggable
@export var front_thigh: Draggable
@export var front_leg: Draggable
@export var front_arm: Draggable
@export var front_forearm: Draggable
@export var rear_arm: Draggable
@export var rear_forearm: Draggable
@export var rear_thigh: Draggable
@export var rear_leg: Draggable

const TORQUE = 2048
const VELOCITY = 1100

var limbs = [head, upper_torso, lower_torso, waist, front_thigh, front_leg, front_arm, front_forearm, rear_arm, rear_forearm, rear_thigh, rear_leg]

func _ready():
	front_thigh.add_collision_exception_with(rear_thigh)
	front_thigh.add_collision_exception_with(rear_leg)
	rear_thigh.add_collision_exception_with(front_thigh)
	rear_leg.add_collision_exception_with(front_leg)
	front_arm.add_collision_exception_with(rear_arm)
	front_forearm.add_collision_exception_with(rear_forearm)
	rear_arm.add_collision_exception_with(rear_arm)
	rear_forearm.add_collision_exception_with(rear_forearm)
	for body_part in [waist, lower_torso, upper_torso, front_leg, front_thigh, rear_leg, rear_thigh]:
		front_arm.add_collision_exception_with(body_part)
		front_forearm.add_collision_exception_with(body_part)
		rear_arm.add_collision_exception_with(body_part)
		rear_forearm.add_collision_exception_with(body_part)

func _physics_process(_delta):
	if alive:
		stand()

func is_on_floor():
	if (weakref(front_leg).get_ref() and weakref(rear_leg).get_ref()) and (front_leg.get_contact_count() > 0 or rear_leg.get_contact_count() > 0):
		return true
	else:
		return false

func stand():
	for limb in [waist, upper_torso, head]:
		if weakref(limb).get_ref():
			#if is_on_floor():
			limb.apply_central_force(Vector2.UP * VELOCITY)
	
	for limb in [front_leg, front_thigh, rear_thigh, rear_leg]:
		if weakref(limb).get_ref() and abs(limb.rotation_degrees) > 10:
			limb.apply_torque(TORQUE * -sign(limb.rotation_degrees))
