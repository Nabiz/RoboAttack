extends Area2D

func _ready():
	$AnimatedSprite.play()

func _on_Explosion_body_entered(body):
	if body.is_in_group("enemies"):
		body.queue_free()


func _on_LifeTimer_timeout():
	queue_free()
