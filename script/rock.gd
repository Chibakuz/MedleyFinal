extends Node2D

var health = 100

func attacked(damage):
	$TextureProgressBar.visible = true
	health -= damage
	$TextureProgressBar.value = health
	$Timer.wait_time = 1 
	$Timer.start()
	
	if health <= 0:
		queue_free()



func _on_area_2d_body_entered(body):
	if is_in_group('player'):
		body.has_method('attacked')
