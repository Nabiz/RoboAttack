extends "res://Pickup/Pickup.gd"

func _ready():
	amount = 40

func add_resource(player, amount):
		if player.weapon.rifle.ammo < player.weapon.rifle.max_ammo:
			player.weapon.rifle.add_ammo(amount)
			player.weapon.update_ammo_HUD()
			remove_pickup()
