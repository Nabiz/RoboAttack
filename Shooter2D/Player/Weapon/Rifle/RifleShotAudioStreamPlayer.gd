extends AudioStreamPlayer2D

func _on_RifleShotAudioStreamPlayer_finished():
	queue_free()
