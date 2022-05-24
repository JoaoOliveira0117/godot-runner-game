extends Area2D

func _on_butterfly_body_entered(body):
	body.jump_amount = 1
	self.queue_free()
