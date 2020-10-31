extends Area2D

var SPEED = 1000

func _physics_process(delta):
	position += Vector2(SPEED * delta,0).rotated(rotation)


func _on_ShotgunBullet_body_entered(body):
	if body.is_in_group("enemies"):
		if body.has_method("start_knockback"):
			body.start_knockback(SPEED)

func _on_ShotgunBullet_body_exited(body):
	if body.is_in_group("enemies"):
		if body.has_method("stop_knockback"):
			body.stop_knockback()

func _on_LifeTime_timeout():
	queue_free()
