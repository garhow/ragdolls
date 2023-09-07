extends Node

class SpawnObject:
	var Name: String
	var File: Resource

enum SpawnTypes {
	OBJECT,
	JOINT,
	WELD,
	CABLE
}

var maps := {
	"basic": {
		"name": "Basic",
		"resource": preload("res://maps/Basic.tscn")
	},
	"box": {
		"name": "Box",
		"resource": preload("res://maps/Box.tscn")
	},
	"plinko": {
		"name": "Plinko",
		"resource": preload("res://maps/Plinko.tscn")
	},
	"pool": {
		"name": "Pool",
		"resource": preload("res://maps/Pool.tscn")
	},
	"target": {
		"name": "Target",
		"resource": preload("res://maps/Target/Target.tscn")
	}
}

var spawnlist := {
	"creatures": {
		"human": {
			"name": "Human",
			"resource": preload("res://objects/creatures/human/Human.tscn")
		},
		"snake": {
			"name": "Snake",
			"resource": preload("res://objects/creatures/snake/Snake.tscn")
		},
	},
	"miscellaneous": {
		"boulder": {
			"name": "Boulder",
			"resource": preload("res://objects/misc/Boulder/Boulder.tscn")
		},
		"large_ball": {
			"name": "Large Ball",
			"resource": preload("res://objects/misc/large_ball.tscn")
		},
		"ramp": {
			"name": "Ramp",
			"resource": preload("res://objects/misc/Ramp/Ramp.tscn")
		},
		"rocket": {
			"name": "Rocket",
			"resource": preload("res://objects/misc/Rocket/Rocket.tscn")
		},
		"trampoline": {
			"name": "Trampoline",
			"resource": preload("res://objects/misc/Trampoline/Trampoline.tscn")
		}
	},
	"weapons": {
		"pistol": {
			"name": "Pistol",
			"resource": preload("res://objects/weapons/pistol/Pistol.tscn")
		}
	},
	"vehicles": {
		"bicycle": {
			"name": "Bicycle",
			"resource": preload("res://objects/vehicles/Bicycle/Bicycle.tscn")
		},
		"car": {
			"name": "Car",
			"resource": preload("res://objects/vehicles/Car/Car.tscn")
		},
		"skateboard": {
			"name": "Skateboard",
			"resource": preload("res://objects/vehicles/Skateboard/Skateboard.tscn")
		}
	}
}

## The object that is selected to be spawned.
var selected_object: PackedScene

# Tools
enum Tools {
	DRAG,
	PIN,
	PULL,
	PUSH,
	LIFT,
	WELD,
	ANTIGRAVITY
}

# Current tool
var tool: Tools = Tools.DRAG

# History of spawned objects, used for undoing
var history := []

# Buffer used for welding, etc.
var buffer := []
var buffer_tool: Tools

var world_size := 2048

func spawn(object: Node2D, parent: Node2D = get_tree().current_scene):
	parent.add_child(object)
	history.append(object.get_path())
