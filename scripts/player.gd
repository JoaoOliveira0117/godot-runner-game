extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 125
var gravity = 1200
var jump_force = -870
var is_grounded

func _physics_process(delta):
	_set_animation()
	is_grounded = is_on_floor()
	velocity.y += gravity * delta
	move_speed = lerp(move_speed, 125, 0.025)
	velocity.x = move_speed
	velocity = move_and_slide(velocity, Vector2.UP, true)
	
	print(velocity.x)
	
	if is_grounded:
		var offset = deg2rad(90)
		$sprite.rotation = (get_floor_normal().angle()) + offset
	else:
		$sprite.rotation = 0
	
func _input(event):
	if event.is_action_pressed("accelerate") and is_grounded:
		move_speed += 300
	
	if event.is_action_pressed("jump") and is_grounded:
		velocity.y = jump_force/2
		
	if event.is_action_released("jump") and velocity.y < -100:
		velocity.y = jump_force/4

func _set_animation():
	var anim = "run"
	
	if not is_grounded:
		anim = "jump"
		
	if $animation_player.assigned_animation != anim:
		$animation_player.play(anim)
