extends AudioStreamPlayer2D


func _on_BlasterShotAudioStreamPlayer_finished():
	queue_free()
