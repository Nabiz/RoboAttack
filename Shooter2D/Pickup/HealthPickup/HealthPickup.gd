extends "res://Pickup/Pickup.gd"

func _ready():
	amount = 400

func add_resource(player, amount):
	if player.health < 2000:
		player.health += amount
		if player.health > 2000:
			player.health = 2000
		player.emit_signal("damage_taken", player.health)
		queue_free()
