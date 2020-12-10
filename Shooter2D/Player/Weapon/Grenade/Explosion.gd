extends Area2D

func _ready():
	$AnimatedSprite.play()
	$AudioStreamPlayer2D.play()

func _on_Explosion_body_entered(body):
	if body.is_in_group("enemies"):
		body.queue_free()


func _on_LifeTimer_timeout():
	visible = false
	set_collision_layer_bit(3, false)
	set_collision_mask_bit(0, false)
	set_collision_mask_bit(1, false)
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
