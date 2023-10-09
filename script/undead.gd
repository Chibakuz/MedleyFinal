extends CharacterBody2D

var is_moving_left = true
var gravity = 10
var speed = 50
var turn_side
var health = 200
@onready var state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity
	
	move_and_slide()

func attacked(damage):
	$TextureProgressBar.visible = true
	health -= damage
	$TextureProgressBar.value = health
	$Timer.wait_time = 1
	$Timer.start()
	
	if health <= 100:
		state_machine.travel("attack2")
	if health <= 0 :
		state_machine.travel('dead')
		$TextureProgressBar.visible = false
	

func _on_detech_player_body_entered(body):
	if body.is_in_group('player'):
		state_machine.travel("attack")

func _on_detech_player_body_exited(body):
	if body.is_in_group('player'):
		state_machine.travel("walk")
		speed = 100

func _on_attack_player_body_entered(body):
	if body.has_method('attacked'):
		body.attacked(15)

		
func _on_area_2d_area_entered(area):
	is_moving_left = !is_moving_left
	scale.x = -scale.x
		
func _on_timer_timeout():
	$TextureProgressBar.visible = false
		




