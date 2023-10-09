extends Area2D


func _on_body_entered(body):
	print('Boss')
	get_tree().change_scene_to_file("res://Scene/boss_scene.tscn")

