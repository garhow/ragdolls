class_name ConveyorBelt extends StaticBody2D

const SPEED = 128

var direction: Vector2

func _ready():
	var line = Line2D.new()
	line.add_point(Game.buffer[0])
	line.add_point(Game.buffer[1])
	line.default_color = Color.DARK_SLATE_GRAY
	add_child(line)
	
	direction = Game.buffer[0].direction_to(Game.buffer[1])
	
	var collision = CollisionPolygon2D.new()
	collision.polygon = [
		Game.buffer[0] + direction.orthogonal() * (line.width / 2),
		Game.buffer[1] + direction.orthogonal() * (line.width / 2),
		Game.buffer[1] - direction.orthogonal() * (line.width / 2),
		Game.buffer[0] - direction.orthogonal() * (line.width / 2)
	]
	
	add_child(collision)
	
	constant_linear_velocity = direction * SPEED
