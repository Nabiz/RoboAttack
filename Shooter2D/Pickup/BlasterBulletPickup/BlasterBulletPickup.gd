extends "res://Pickup/Pickup.gd"

func _ready():
	amount = 20

func add_resource(player, amount):
		if player.weapon.blaster.ammo < player.weapon.blaster.max_ammo:
			player.weapon.blaster.add_ammo(amount)
			player.weapon.update_ammo_HUD()
			queue_free()
