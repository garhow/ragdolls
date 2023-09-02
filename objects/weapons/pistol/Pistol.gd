extends Draggable

## How many rounds the pistol's magazine can hold
@export var ammo_count := 8 

# Sounds
@export var dry_fire_sound : AudioStreamPlayer2D
@export var fire_sound : AudioStreamPlayer2D

func _interact():
	if ammo_count > 0:
		fire_sound.play()
		ammo_count -= 1
	else:
		dry_fire_sound.play()
