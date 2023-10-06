extends RigidBody2D

var health = 10

func attacked():
	health -= 5
	
	if health == 0:
		queue_free()
	
