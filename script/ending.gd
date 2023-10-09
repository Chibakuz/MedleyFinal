extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scene/thank.tscn")

