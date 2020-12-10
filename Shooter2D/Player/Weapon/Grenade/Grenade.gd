extends KinematicBody2D

var speed = 0
export (PackedScene) var Explosion


func _physics_process(delta):
	move_and_collide(Vector2(speed*delta,0).rotated(rotation))

func throw(destination):
	var length = position.distance_to(destination)
	speed = length

func _on_ExplosionTimer_timeout():
	var explosion = Explosion.instance()
	explosion.position = global_position
	get_tree().root.add_child(explosion)
	queue_free()
