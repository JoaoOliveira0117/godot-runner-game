extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 125
var gravity = 1200
var jump_force = -870
var is_grounded

var coins = 0

onready var raycasts = $raycasts
onready var camera = $Camera2D

func _ready():
	# Allow camera to start at the left side instead of center.
	camera.drag_margin_right = -0.75

func _physics_process(delta):
	_set_animation()
	is_grounded = check_is_on_ground()
	velocity.y += gravity * delta
	move_speed = lerp(move_speed, 125, 0.025)
	velocity.x = move_speed
	velocity = move_and_slide(velocity, Vector2.UP, true)
	
	var floor_normal = get_floor_normal().angle()
	var offset = deg2rad(90)
	
	if is_grounded and floor_normal != 0:
		$sprite.rotation = floor_normal + offset
	else:
		$sprite.rotation = 0
	
func _input(event):
	if event.is_action_pressed("accelerate") and is_grounded:
		move_speed += 300
	
	if event.is_action_pressed("jump") and is_grounded:
		velocity.y = jump_force/2
		
	if event.is_action_released("jump") and velocity.y < -100:
		velocity.y = jump_force/4

func check_is_on_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	
	return false

func _set_animation():
	var anim = "run"
	
	if not is_grounded:
		anim = "jump"
		
	if $animation_player.assigned_animation != anim:
		$animation_player.play(anim)
