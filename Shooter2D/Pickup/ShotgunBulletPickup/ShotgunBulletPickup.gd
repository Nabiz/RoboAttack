extends "res://Pickup/Pickup.gd"

func _ready():
	amount = 8

func add_resource(player, amount):
		if player.weapon.shotgun.ammo < player.weapon.shotgun.max_ammo:
			player.weapon.shotgun.add_ammo(amount)
			player.weapon.update_ammo_HUD()
			queue_free()
