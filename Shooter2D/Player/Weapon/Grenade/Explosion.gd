extends Area2D

var damage = 1000

func _ready():
	$AnimatedSprite.play()
	$AudioStreamPlayer2D.play()

func _on_Explosion_body_entered(body):
	if body.is_in_group("enemies") or body.name == "Player":
		body.take_damage(damage)


func _on_LifeTimer_timeout():
	visible = false
	set_collision_layer_bit(3, false)
	set_collision_mask_bit(0, false)
	set_collision_mask_bit(1, false)
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
