extends KinematicBody2D

var jump_sound = preload("res://scenes/sounds/jump_sound.tscn")

var velocity = Vector2.ZERO
var move_speed = 125
var gravity = 1200
var jump_force = -870

var jump_amount = 1
var coins = 0

onready var raycasts = $raycasts
onready var camera = $Camera2D

func _ready():
	# Allow camera to start at the left side instead of center.
	camera.drag_margin_right = -0.75

func _physics_process(delta):
	_set_animation()
	velocity.y += gravity * delta
	move_speed = lerp(move_speed, 125, 0.025)
	velocity.x = move_speed
	velocity = move_and_slide(velocity, Vector2.UP, true)
	
	var floor_normal = get_floor_normal().angle()
	var offset = deg2rad(90)
	
	print(jump_amount)
	
	if is_on_floor():
		jump_amount = 1
	
	if is_on_floor() and floor_normal != 0:
		$sprite.rotation = floor_normal + offset
	else:
		$sprite.rotation = 0
	
func _input(event):
	if event.is_action_pressed("accelerate") and is_on_floor():
		move_speed += 300
	
	if event.is_action_pressed("jump") and jump_amount > 0:
		get_tree().current_scene.add_child(jump_sound.instance())
		jump_amount = 0
		velocity.y = jump_force/2
		
	if event.is_action_released("jump") and velocity.y < -100:
		velocity.y = jump_force/4

func _set_animation():
	var anim = "run"
	
	if not is_on_floor():
		anim = "jump"
		
	if $animation_player.assigned_animation != anim:
		$animation_player.play(anim)
