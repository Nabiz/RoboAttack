extends AudioStreamPlayer2D

func _on_DamageAudioStreamPlayer_finished():
	queue_free()
