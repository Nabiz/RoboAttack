extends "res://Pickup/Pickup.gd"

func _ready():
	amount = 1

func add_resource(player, amount):
		if player.weapon.granade_count < 3:
			player.weapon.granade_count += amount
			player.weapon.update_granade_HUD()
			queue_free()
