extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var state_machine
var health = 100 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	state_machine =$AnimationTree.get('parameters/playback')
	

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		state_machine.travel("idle")

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions. 
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		state_machine.travel("walk")
		if Input.is_action_pressed("ui_left"):
			$Sprite2D.flip_h = true
		elif Input.is_action_pressed("ui_right"):
			$Sprite2D.flip_h = false
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		state_machine.travel("idle")
		
	if Input.is_action_pressed("attack"):
		get_node("AudioStreamPlayer2D").play()
		$Timer.wait_time = 3
		state_machine.travel("attack")
		
	if health <= 0: 
		death()

	move_and_slide()
	
func _on_attack_player_body_entered(body):
	if body.has_method('attacked'):
		body.attacked(25)
		
func attacked(damage):
	$TextureProgressBar.visible = true
	health -= damage
	$TextureProgressBar.value = health
	$Timer.wait_time = 1
	$Timer.start()
		

func death():
	state_machine.travel("dead")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scene/state_1.tscn")
	
	
func _on_timer_timeout():
	$TextureProgressBar.visible = false
	


func _on_area_2d_body_entered(body):
	pass # Replace with function body.
