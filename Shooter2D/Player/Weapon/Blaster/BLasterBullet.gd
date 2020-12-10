extends KinematicBody2D

var SPEED = 400
var power = 300

func _physics_process(delta):
	var collision = move_and_collide(Vector2(SPEED * delta,0).rotated(rotation))
	if collision:
		if collision.collider.is_in_group("enemies"):
			if collision.collider.has_method("take_damage"):
				collision.collider.take_damage(power)
			else:
				collision.collider.queue_free()
		queue_free()
