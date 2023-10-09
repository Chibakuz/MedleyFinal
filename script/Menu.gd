extends Node2D


func _on_stat_pressed():

	get_tree().change_scene_to_file("res://Scene/state_1.tscn")

func _on_quit_pressed():
	get_tree().quit()
