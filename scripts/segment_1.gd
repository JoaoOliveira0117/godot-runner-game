extends Node2D

onready var player = get_tree().get_root().get_node("game").get_node("player")

func _process(delta):
	if global_position.distance_to(player.global_position) > 550:
		self.queue_free()
