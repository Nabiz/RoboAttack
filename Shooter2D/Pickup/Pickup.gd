extends Area2D

var amount

func _on_Pickup_body_entered(body):
	if body.name == "Player":
		add_resource(body, amount)

func add_resource(player, amount):
	queue_free()

func remove_pickup():
	$AudioStreamPlayer2D.play()
	visible = false
	set_collision_layer_bit(3, false)
	set_collision_mask_bit(0, false)
	yield(get_tree().create_timer(2), "timeout")
	queue_free()
