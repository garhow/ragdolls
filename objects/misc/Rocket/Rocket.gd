extends Draggable

var activated := false

@export var particles: CPUParticles2D

func _interact():
	activated = !activated
	particles.emitting = activated

func _custom_physics_process(_delta):
	if activated: add_constant_central_force(Vector2.UP.rotated(rotation) * 128)
