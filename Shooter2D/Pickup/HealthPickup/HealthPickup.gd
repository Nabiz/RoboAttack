extends "res://Pickup/Pickup.gd"

func _ready():
	amount = 200

func add_resource(player, amount):
	if player.health < 1000:
		player.health += amount
		player.emit_signal("damage_taken", player.health)
		queue_free()
