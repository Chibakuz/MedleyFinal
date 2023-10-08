extends Area2D

func _on_body_entered(body):
	print('staet 2')
	get_tree().change_scene_to_file("res://Scene/state_3.tscn")
