class_name Platform extends StaticBody2D

func _ready():
	var line = Line2D.new()
	line.add_point(Game.buffer[0])
	line.add_point(Game.buffer[1])
	line.default_color = Color.BLACK
	add_child(line)
	
	var direction: Vector2 = Game.buffer[0].direction_to(Game.buffer[1])
	
	var collision = CollisionPolygon2D.new()
	collision.polygon = [
		Game.buffer[0] + direction.orthogonal() * (line.width / 2),
		Game.buffer[1] + direction.orthogonal() * (line.width / 2),
		Game.buffer[1] - direction.orthogonal() * (line.width / 2),
		Game.buffer[0] - direction.orthogonal() * (line.width / 2)
	]
	
	add_child(collision)
