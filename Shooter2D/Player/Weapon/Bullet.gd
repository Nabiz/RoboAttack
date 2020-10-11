extends KinematicBody2D

var SPEED = 500

func _physics_process(delta):
    var collision = move_and_collide(Vector2(SPEED * delta,0).rotated(rotation))
    if collision:
        if collision.collider.is_in_group("enemies"):
            collision.collider.queue_free()
        queue_free()
