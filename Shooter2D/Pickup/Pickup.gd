extends Area2D

var amount

func _on_Pickup_body_entered(body):
	if body.name == "Player":
		add_resource(body, amount)

func add_resource(player, amount):
	queue_free()
