extends Area2D


func _on_body_entered(body):
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scene/ending.tscn")
