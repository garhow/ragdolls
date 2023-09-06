extends Draggable

func _on_body_entered(body):
	if body is RigidBody2D:
		body.linear_velocity.y -= 1024
