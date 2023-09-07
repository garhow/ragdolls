class_name Pin extends StaticBody2D

var parent : PhysicsBody2D

func _init(new_parent: PhysicsBody2D):
	parent = new_parent

func _ready():
	position = get_local_mouse_position()
	
	var sprite = Sprite2D.new()
	sprite.texture = load("res://objects/misc/peg.png")
	sprite.texture_filter = TEXTURE_FILTER_NEAREST
	
	var pin = PinJoint2D.new()
	pin.position = get_local_mouse_position()
	pin.node_a = get_path()
	pin.node_b = parent.get_path()
	pin.add_child(sprite)
	
	add_child(pin)
