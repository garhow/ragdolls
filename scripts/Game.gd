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
		"car": {
			"name": "Car",
			"resource": preload("res://objects/vehicles/Car/Car.tscn")
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
	LIFT
}

# Current tool
var tool: Tools = Tools.DRAG
