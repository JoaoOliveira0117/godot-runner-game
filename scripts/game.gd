extends Node2D

func _on_start_button_pressed():
	$ground_spawner/Timer.start()
	$CanvasLayer.queue_free()


func _on_quit_button_pressed():
	get_tree().quit()
