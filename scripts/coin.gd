extends Area2D

func _on_coin_body_entered(body):
	body.coins += 1
	self.queue_free()
