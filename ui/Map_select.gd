extends GridContainer

@export var basic_scene : PackedScene
@export var plinko_scene : PackedScene

func _on_basic_pressed(): get_tree().change_scene_to_packed(basic_scene)
func _on_plinko_pressed(): get_tree().change_scene_to_packed(plinko_scene)
