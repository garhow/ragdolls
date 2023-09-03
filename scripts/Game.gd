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
	"plinko": {
		"name": "Plinko",
		"resource": preload("res://maps/Plinko.tscn")
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
		"ball": {
			"name": "Ball",
			"resource": preload("res://objects/misc/ball.tscn")
		},
		"large_ball": {
			"name": "Large Ball",
			"resource": preload("res://objects/misc/large_ball.tscn")
		}
	},
	"weapons": {
		"pistol": {
			"name": "Pistol",
			"resource": preload("res://objects/weapons/pistol/Pistol.tscn")
		}
	}
}

## The object that is selected to be spawned.
var selected_object: PackedScene
