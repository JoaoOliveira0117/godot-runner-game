extends Node2D

var is_level_start = true

const default_segment = preload("res://scenes/ground/segments/default.tscn")

const segments = [
	preload("res://scenes/ground/segments/segment_1.tscn"),
	preload("res://scenes/ground/segments/segment_2.tscn"),
	preload("res://scenes/ground/segments/segment_3.tscn"),
	#preload("res://scenes/ground/segments/segment_4.tscn")
]

const segment_width = 384
var spawn_position = global_position
onready var player = get_parent().get_node("player")

func _ready():
	randomize()

func _process(delta):
	if spawn_position.distance_to(player.global_position) < 450:
		spawn_segment()

func spawn_segment():
	var spawn_segment_instance
	if is_level_start:
		spawn_segment_instance = default_segment.instance()
	else:
		var random_instance = randi() % len(segments)
		spawn_segment_instance = segments[random_instance].instance()
		
	add_child(spawn_segment_instance)
	
	spawn_segment_instance.global_position.x = spawn_position.x
	spawn_position.x = spawn_position.x + segment_width


func _on_Timer_timeout():
	is_level_start = false


