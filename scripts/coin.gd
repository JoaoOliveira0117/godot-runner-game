extends Area2D

const coin_sound = preload("res://scenes/sounds/coin_sound.tscn")

func _on_coin_body_entered(body):
	get_tree().current_scene.add_child(coin_sound.instance())
	body.coins += 1
	self.queue_free()
